import 'package:drift/drift.dart';

class TransactionLabels extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get color => text()();
  DateTimeColumn get lastEdit => dateTime()();
}
