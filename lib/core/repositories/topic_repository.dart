import 'package:organizer/core/models/topic.dart';

abstract class TopicRepository {
  Future<List<Topic>> getAllTopics();
  Future<List<Topic>> getAllTopicsByCategoryId(int categoryId);
  Future<void> addTopic(
    int categoryId,
    String name,
    DateTime lastEdit,
    String? description,
  );
  Future<void> updateTopic(
    int id,
    int categoryId,
    String name,
    DateTime lastEdit,
    String? description,
  );
  Future<void> deleteTopic(int id);
}
