import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';

abstract class TopicRepository {
  Future<List<Topic>> getAllTopicsByCategory(Category category);
  Future<void> addTopic(Topic topic);
  Future<void> removeTopic(int id);
}