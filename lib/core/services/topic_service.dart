import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';

class TopicService {
  final TopicRepository repository;

  TopicService(this.repository);

  Future<List<Topic>> getAllTopics() async => await repository.getAllTopics();
  Future<List<Topic>> getAllTopicsByCategoryId(int categoryId) async =>
      await repository.getAllTopicsByCategoryId(categoryId);
  Future<void> addTopic(
    int categoryId,
    String name,
    DateTime lastEdit,
    String? description,
  ) async => await repository.addTopic(categoryId, name, lastEdit, description);
  Future<void> updateTopic(
    int id,
    int categoryId,
    String name,
    DateTime lastEdit,
    String? description,
  ) async =>
      await repository.updateTopic(id, categoryId, name, lastEdit, description);
  Future<void> deleteTopic(int id) async => await repository.deleteTopic(id);
}
