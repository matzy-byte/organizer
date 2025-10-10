import 'package:isar/isar.dart';
import 'package:organizer/data/models/category_isar.dart';

part 'topic_isar.g.dart';

@collection
class TopicIsar {
  Id id = Isar.autoIncrement;
  final category = IsarLink<CategoryIsar>();
  late String name;
  String? description;
}
