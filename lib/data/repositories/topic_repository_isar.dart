import 'package:flutter/src/foundation/annotations.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';

class TopicRepositoryIsar implements TopicRepository {
  @override
  Future<void> addTopic(Topic topic) {
    // TODO: implement addTopic
    throw UnimplementedError();
  }

  @override
  Future<List<Topic>> getAllTopicsByCategory(Category category) {
    // TODO: implement getAllTopicsByCategory
    throw UnimplementedError();
  }

  @override
  Future<void> removeTopic(String topicId) {
    // TODO: implement removeTopic
    throw UnimplementedError();
  }
}