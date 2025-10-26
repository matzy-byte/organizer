import 'package:drift/drift.dart';
import 'package:organizer/data/database/tables/topics.dart';

class VarTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get topicId => integer().references(Topics, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get value => integer()();
  TextColumn get compensations => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get fixRefId => integer().nullable()();
  IntColumn get varRefId => integer().nullable()();
}
