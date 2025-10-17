import 'package:organizer/core/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
  Future<void> addCategory(String name, String? description);
  Future<void> removeCategory(Category category);
}