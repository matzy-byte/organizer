import 'package:organizer/core/models/topic.dart';

abstract class TopicRepository {
  Future<List<Topic>> getAllTopics();
  Future<List<Topic>> getAllTopicsByCategoryId(int categoryId);
  Future<void> addTopic(int categoryId, String name, String? description);
  Future<void> removeTopic(int id);
}
