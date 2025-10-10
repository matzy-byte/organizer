import 'package:organizer/core/models/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAllCategories();
  Future<void> addCategory(Category category);
  Future<void> removeCategory(int id);
}