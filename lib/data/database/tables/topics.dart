import 'package:drift/drift.dart';
import 'package:organizer/data/database/tables/categories.dart';

class Topics extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id)();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get description => text().nullable()();
}
