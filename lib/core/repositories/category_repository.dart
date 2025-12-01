import 'package:organizer/core/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
  Future<void> addCategory(String name, DateTime lastEdit, String? description);
  Future<void> updateCategory(
    int id,
    String name,
    DateTime lastEdit,
    String? description,
  );
  Future<void> deleteCategory(int id);
}
