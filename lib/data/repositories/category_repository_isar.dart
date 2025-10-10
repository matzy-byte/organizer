import 'package:isar/isar.dart';
import 'package:organizer/data/models/category_isar.dart';
import 'package:organizer/data/isar_provider.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/repositories/category_repository.dart';

class CategoryRepositoryIsar implements CategoryRepository {
  @override
  Future<void> addCategory(Category category) async {
    final isar = await IsarProvider.instance;
    final cat = CategoryIsar()
      ..name = category.name
      ..description = category.description;
    await isar.writeTxn(() async => await isar.categoryIsars.put(cat));
  }

  @override
  Future<List<Category>> getAllCategories() async {
    final isar = await IsarProvider.instance;
    final cats = await isar.categoryIsars.where().findAll();
    return cats.map((c) => Category(
      id: c.id,
      name: c.name,
      description: c.description,
    )).toList();
  }

  @override
  Future<void> removeCategory(int id) async {
    final isar = await IsarProvider.instance;
    await isar.writeTxn(() async {
      await isar.categoryIsars.delete(id);
    });
  }
}