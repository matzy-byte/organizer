import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService categoryService;
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  CategoryProvider({required this.categoryService});

  Future<void> loadCategories() async {
    _categories = await categoryService.getAllCategories();
    notifyListeners();
  }

  Future<void> addCategory(String name, String? description) async {
    await categoryService.addCategory(name, description);
    await loadCategories();
  }

  Future<void> removeCategory(Category category) async {
    await categoryService.removeCategory(category);
    await loadCategories();
  }
}