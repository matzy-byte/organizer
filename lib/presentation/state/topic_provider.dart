import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/services/topic_service.dart';

class TopicProvider with ChangeNotifier {
  final TopicService topicService;

  TopicProvider({required this.topicService});

  Future<List<Topic>> loadTopicsByCategory(Category category) async {
    return await topicService.getAllTopicsByCategory(category);
  }

  Future<void> addTopic(Category category, String name, String? description) async {
    await topicService.addTopic(category, name, description);
  }

  Future<void> removeTopic(Topic topic) async {
    await topicService.removeTopic(topic);
  }
}