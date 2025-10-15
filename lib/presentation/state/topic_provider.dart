import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/services/topic_service.dart';

class TopicProvider with ChangeNotifier {
  final TopicService topicService;
  List<Topic> _topics = [];
  List<Topic> get topics => _topics;

  TopicProvider({required this.topicService});

  Future<void> loadAllTopics() async {
    _topics = await topicService.getAllTopics();
    notifyListeners();
  }

  Future<List<Topic>> loadTopicsByCategory(Category category) async {
    return await topicService.getAllTopicsByCategory(category);
  }

  Future<void> addTopic(Category category, String name, String? description) async {
    await topicService.addTopic(category, name, description);
    loadAllTopics();
  }

  Future<void> removeTopic(Topic topic) async {
    await topicService.removeTopic(topic);
    loadAllTopics();
  }
}