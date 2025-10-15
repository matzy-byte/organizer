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

  Future<void> addCategory(String name) async {
    await categoryService.addCategory(Category(id: DateTime.now().millisecondsSinceEpoch, name: name));
    await loadCategories();
  }

  Future<void> removeCategory(int id) async {
    await categoryService.removeCategory(id);
    await loadCategories();
  }
}