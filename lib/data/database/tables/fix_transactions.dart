import 'package:drift/drift.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/data/database/tables/files.dart';
import 'package:organizer/data/database/tables/topics.dart';
import 'package:organizer/data/database/tables/transaction_labels.dart';
import 'package:organizer/data/database/tables/users.dart';
import 'package:organizer/data/database/tables/var_transactions.dart';

class FixTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get topicId => integer().references(Topics, #id, onDelete: KeyAction.cascade)();
  TextColumn get status => textEnum<Status>()();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime()();
  IntColumn get intervalCount => integer()();
  TextColumn get intervalUnit => textEnum<IntervalUnit>()();
  IntColumn get value => integer()();
  IntColumn get userRefId => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get lastEdit => dateTime()();
  TextColumn get compensations => text().nullable()();
  IntColumn get transactionLabelId =>
      integer().references(TransactionLabels, #id, onDelete: KeyAction.setNull).nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get latestDate => dateTime().nullable()();
  IntColumn get varRefId =>
      integer().references(VarTransactions, #id, onDelete: KeyAction.setNull).nullable()();
  IntColumn get fileRefId => integer().references(Files, #id, onDelete: KeyAction.setNull).nullable()();
}
