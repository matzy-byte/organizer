import 'package:drift/drift.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';
import 'package:organizer/core/utils/json_util.dart';
import 'package:organizer/data/database/database.dart' hide Topic;

class TopicRepositoryDrift implements TopicRepository {
  final AppDatabase db;
  TopicRepositoryDrift(this.db);

  @override
  Future<void> addTopic(
    int categoryId,
    String name,
    String? description,
  ) async {
    await db
        .into(db.topics)
        .insert(
          TopicsCompanion.insert(
            categoryId: categoryId,
            name: name,
            description: Value(description),
          ),
        );
  }

  @override
  Future<List<Topic>> getAllTopicsByCategoryId(int categoryId) async {
    final rows = await (db.select(
      db.topics,
    )..where((t) => t.categoryId.equals(categoryId))).get();
    return rows
        .map(
          (t) => Topic(
            id: t.id,
            categoryId: t.categoryId,
            name: t.name,
            description: t.description,
          ),
        )
        .toList();
  }

  @override
  Future<void> removeTopic(int id) async {
    await db.transaction(() async {
      final varTransactions = await (db.select(
        db.varTransactions,
      )..where((v) => v.topicId.equals(id))).get();

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

      await (db.delete(db.topics)..where((t) => t.id.equals(id))).go();
    });
  }

  @override
  Future<List<Topic>> getAllTopics() async {
    final rows = await db.select(db.topics).get();
    return rows
        .map(
          (t) => Topic(
            id: t.id,
            categoryId: t.categoryId,
            name: t.name,
            description: t.description,
          ),
        )
        .toList();
  }
}
