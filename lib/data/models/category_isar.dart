import 'package:isar/isar.dart';
import 'package:organizer/data/models/topic_isar.dart';

part 'category_isar.g.dart';

@collection
class CategoryIsar {
  Id id = Isar.autoIncrement;
  late String name;
  String? description;
  final topics = IsarLinks<TopicIsar>();
}