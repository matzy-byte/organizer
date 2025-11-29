import 'package:drift/drift.dart';
import 'package:organizer/core/utils/json_util.dart';
import 'package:organizer/data/database/database.dart' hide Category;
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/repositories/category_repository.dart';

class CategoryRepositoryDrift implements CategoryRepository {
  final AppDatabase db;
  CategoryRepositoryDrift(this.db);

  @override
  Future<void> addCategory(String name, String? description) async {
    await db
        .into(db.categories)
        .insert(
          CategoriesCompanion.insert(
            name: name,
            description: Value(description),
            lastEdit: DateTime.now(),
          ),
        );
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final rows = await db.select(db.categories).get();
    return rows
        .map(
          (c) => Category(
            id: c.id,
            name: c.name,
            description: c.description,
            lastEdit: c.lastEdit,
          ),
        )
        .toList();
  }

  @override
  Future<void> removeCategory(int categoryId) async {
    await db.transaction(() async {
      final topics = await (db.select(
        db.topics,
      )..where((t) => t.categoryId.equals(categoryId))).get();
      final topicIds = topics.map((t) => t.id).toList();

      final varTransactions = await (db.select(
        db.varTransactions,
      )..where((v) => v.topicId.isIn(topicIds))).get();

      for (final varTransaction in varTransactions) {
        if (varTransaction.compensations != null) {
          final compensations = JsonUtil.string2CompensationInfo(
            varTransaction.compensations,
          )!;
          for (final cId in compensations.keys) {
            await (db.delete(
              db.varTransactions,
            )..where((vT) => vT.id.equals(cId))).go();
          }
        }

        if (varTransaction.varRefId != null) {
          final parent =
              await (db.select(db.varTransactions)
                    ..where((v) => v.id.equals(varTransaction.varRefId!)))
                  .getSingleOrNull();
          if (parent != null && parent.compensations != null) {
            final parentComps = JsonUtil.string2CompensationInfo(
              parent.compensations,
            )!;
            parentComps.remove(varTransaction.id);
            final updatedComps = parentComps.isEmpty ? null : parentComps;
            await (db.update(
              db.varTransactions,
            )..where((v) => v.id.equals(parent.id))).write(
              VarTransactionsCompanion(
                compensations: Value(
                  JsonUtil.compensation2String(updatedComps),
                ),
              ),
            );
          }
        }
      }

      await (db.delete(
        db.categories,
      )..where((c) => c.id.equals(categoryId))).go();
    });
  }
}
