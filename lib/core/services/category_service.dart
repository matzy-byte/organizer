import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/repositories/category_repository.dart';

class CategoryService {
  final CategoryRepository repository;

  CategoryService(this.repository);

  Future<List<Category>> getAllCategories() async {
    final cats = await repository.getAllCategories();
    if (cats.isEmpty) {
      return [];
    }
    return cats;
  }

  Future<void> addCategory(
    String name,
    DateTime lastEdit,
    String? description,
  ) => repository.addCategory(name, lastEdit, description);
  Future<void> updateCategory(
    int id,
    String name,
    DateTime lastEdit,
    String? description,
  ) => repository.updateCategory(id, name, lastEdit, description);
  Future<void> deleteCategory(int categoryId) =>
      repository.deleteCategory(categoryId);
}
