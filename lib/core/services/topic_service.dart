import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';

class TopicService {
  final TopicRepository repository;

  TopicService(this.repository);

  Future<List<Topic>> getAllTopicsByCategory(Category category) async {
    final topics = await repository.getAllTopicsByCategory(category);
    if (topics.isEmpty) {
      return [];
    }
    return topics;
  }

  Future<void> addTopic(Category category, String name, String? description) => repository.addTopic(category, name, description);
  Future<void> removeTopic(Topic topic) => repository.removeTopic(topic);
}
