import 'package:organizer/core/models/category.dart';

class Topic {
  final int id;
  final Category category;
  final String name;
  final String? description;

  const Topic({
    required this.id,
    required this.category,
    required this.name,
    this.description,
  });
}
