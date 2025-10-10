import 'package:organizer/core/models/topic.dart';

class Category {
  final String id;
  final String name;
  final String? description;
  final List<Topic> topics;

  const Category({
    required this.id,
    required this.name,
    this.description,
    this.topics = const [],
  });
}
