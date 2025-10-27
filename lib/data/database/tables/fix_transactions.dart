import 'package:drift/drift.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/data/database/tables/topics.dart';
import 'package:organizer/data/database/tables/var_transactions.dart';

class FixTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get topicId => integer().references(Topics, #id)();
  TextColumn get status => textEnum<Status>()();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime()();
  IntColumn get intervalCount => integer()();
  TextColumn get intervalUnit => textEnum<IntervalUnit>()();
  IntColumn get value => integer()();
  TextColumn get compensations => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get latestDate => dateTime().nullable()();
  IntColumn get varRefId =>
      integer().references(VarTransactions, #id).nullable()();
}
