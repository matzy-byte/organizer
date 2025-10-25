import 'package:drift/drift.dart';
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
          ),
        );
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final rows = await db.select(db.categories).get();
    return rows
        .map(
          (c) => Category(id: c.id, name: c.name, description: c.description),
        )
        .toList();
  }

  @override
  Future<void> removeCategory(int categoryId) async {
    await (db.delete(
      db.categories,
    )..where((c) => c.id.equals(categoryId))).go();
  }
}
