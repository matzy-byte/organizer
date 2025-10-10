import 'package:isar/isar.dart';

part 'topic_isar.g.dart';

@collection
class TopicIsar {
  Id id = Isar.autoIncrement;
  late String name;
  String? description;
}
