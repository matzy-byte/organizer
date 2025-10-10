import 'package:isar/isar.dart';

part 'category_isar.g.dart';

@collection
class CategoryIsar {
  Id id = Isar.autoIncrement;
  late String name;
  String? description;
}