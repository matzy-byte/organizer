import 'package:isar/isar.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/topic_repository.dart';
import 'package:organizer/data/isar_provider.dart';
import 'package:organizer/data/models/category_isar.dart';
import 'package:organizer/data/models/topic_isar.dart';

class TopicRepositoryIsar implements TopicRepository {
  @override
  Future<void> addTopic(Category category, String name, String? description) async {
    final isar = await IsarProvider.instance;
    final tpc = TopicIsar()
      ..name = name
      ..description = description;
    final cat = await isar.categoryIsars
        .filter()
        .idEqualTo(category.id)
        .findFirst();
    tpc.category.value = cat;
    await isar.writeTxn(() async {
      await isar.topicIsars.put(tpc);
      await tpc.category.save();
    });
  }

  @override
  Future<List<Topic>> getAllTopicsByCategory(Category category) async {
    final isar = await IsarProvider.instance;
    final tpcs = await isar.topicIsars
        .filter()
        .category((q) => q.idEqualTo(category.id))
        .findAll();
    return tpcs
        .map(
          (t) => Topic(id: t.id, category: category, name: t.name, description: t.description),
        )
        .toList();
  }

  @override
  Future<void> removeTopic(Topic topic) async {
    final isar = await IsarProvider.instance;
    await isar.writeTxn(() async {
      await isar.topicIsars.delete(topic.id);
    });
  }
  
  @override
  Future<List<Topic>> getAllTopics() async {
    final isar = await IsarProvider.instance;
    final cats = await isar.categoryIsars.where().findAll();
    final categories = cats.map((c) => Category(id: c.id, name: c.name, description: c.description));
    final tpcs = await isar.topicIsars.where().findAll();
    final topics = <Topic>[];
    for (final t in tpcs) {
      await t.category.load();
      final category = t.category.value;
      if (category == null) return [];
      topics.add(Topic(
        id: t.id,
        category: categories.firstWhere((c) => c.id == category.id),
        name: t.name,
        description: t.description,
      ));
    }
    return topics;
  }
}
