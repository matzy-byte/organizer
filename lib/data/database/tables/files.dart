import 'package:drift/drift.dart';

class Files extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  DateTimeColumn get lastEdit => dateTime()();
}
