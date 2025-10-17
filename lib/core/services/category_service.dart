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

  Future<void> addCategory(String name, String? description) =>
      repository.addCategory(name, description);
  Future<void> removeCategory(Category category) => repository.removeCategory(category);
}
