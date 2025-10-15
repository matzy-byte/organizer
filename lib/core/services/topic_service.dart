import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';

class TopicService {
  final TopicRepository repository;

  TopicService(this.repository);

  Future<List<Topic>> getAllTopics() async => await repository.getAllTopics();
  Future<List<Topic>> getAllTopicsByCategory(Category category) async => await repository.getAllTopicsByCategory(category);
  Future<void> addTopic(Category category, String name, String? description) async => await repository.addTopic(category, name, description);
  Future<void> removeTopic(Topic topic) async => await repository.removeTopic(topic);
}
