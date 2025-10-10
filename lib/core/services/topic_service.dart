import 'package:flutter/foundation.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';

class TopicService {
  final TopicRepository repository;

  TopicService(this.repository);

  Future<List<Topic>> loadCategories(Category category) async {
    final topics = await repository.getAllTopicsByCategory(category);
    if (topics.isEmpty) {
      return [];
    }
    return topics;
  }

  Future<void> addTopic(Topic topic) =>
      repository.addTopic(topic);
  Future<void> removeTopic(String id) => repository.removeTopic(id);
}
