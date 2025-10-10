import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService service;
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  CategoryProvider({required this.service});

  Future<void> loadCategories() async {
    _categories = await service.loadCategories();
    notifyListeners();
  }

  Future<void> addCategory(String name) async {
    await service.addCategory(Category(id: DateTime.now().millisecondsSinceEpoch, name: name));
    await loadCategories();
  }

  Future<void> removeCategory(int id) async {
    await service.removeCategory(id);
    await loadCategories();
  }
}