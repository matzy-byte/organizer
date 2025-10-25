import 'package:drift/drift.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';
import 'package:organizer/data/database/database.dart' hide Topic;

class TopicRepositoryDrift implements TopicRepository {
  final AppDatabase db;
  TopicRepositoryDrift(this.db);

  @override
  Future<void> addTopic(
    int categoryId,
    String name,
    String? description,
  ) async {
    await db
        .into(db.topics)
        .insert(
          TopicsCompanion.insert(
            categoryId: categoryId,
            name: name,
            description: Value(description),
          ),
        );
  }

  @override
  Future<List<Topic>> getAllTopicsByCategoryId(int categoryId) async {
    final rows = await (db.select(
      db.topics,
    )..where((t) => t.categoryId.equals(categoryId))).get();
    return rows
        .map(
          (t) => Topic(
            id: t.id,
            categoryId: t.categoryId,
            name: t.name,
            description: t.description,
          ),
        )
        .toList();
  }

  @override
  Future<void> removeTopic(int id) async {
    await (db.delete(db.topics)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<List<Topic>> getAllTopics() async {
    final rows = await db.select(db.topics).get();
    return rows
        .map(
          (t) => Topic(
            id: t.id,
            categoryId: t.categoryId,
            name: t.name,
            description: t.description,
          ),
        )
        .toList();
  }
}
