import 'package:drift/drift.dart';
import 'package:organizer/data/database/tables/categories.dart';

class Topics extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer().references(Categories, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  DateTimeColumn get lastEdit => dateTime()();
  TextColumn get description => text().nullable()();
}
