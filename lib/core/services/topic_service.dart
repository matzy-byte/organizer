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
    String? description,
  ) async => await repository.addTopic(categoryId, name, description);
  Future<void> removeTopic(int id) async => await repository.removeTopic(id);
}
