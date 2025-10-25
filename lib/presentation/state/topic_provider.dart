import 'package:flutter/material.dart';
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

  Future<List<Topic>> loadTopicsByCategory(int categoryId) async {
    return await topicService.getAllTopicsByCategoryId(categoryId);
  }

  Future<void> addTopic(int categoryId, String name, String? description) async {
    await topicService.addTopic(categoryId, name, description);
    loadAllTopics();
  }

  Future<void> removeTopic(int id) async {
    await topicService.removeTopic(id);
    loadAllTopics();
  }
}