import 'package:drift/drift.dart';
import 'package:organizer/data/database/tables/files.dart';
import 'package:organizer/data/database/tables/fix_transactions.dart';
import 'package:organizer/data/database/tables/topics.dart';
import 'package:organizer/data/database/tables/transaction_labels.dart';
import 'package:organizer/data/database/tables/users.dart';

class VarTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get topicId => integer().references(Topics, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  IntColumn get value => integer()();
  IntColumn get userRefId => integer().references(Users, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get lastEdit => dateTime()();
  TextColumn get compensations => text().nullable()();
  IntColumn get transactionLabelId =>
      integer().references(TransactionLabels, #id, onDelete: KeyAction.setNull).nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get fixRefId =>
      integer().references(FixTransactions, #id, onDelete: KeyAction.setNull).nullable()();
  IntColumn get varRefId =>
      integer().references(VarTransactions, #id, onDelete: KeyAction.setNull).nullable()();
  IntColumn get fileRefId => integer().references(Files, #id, onDelete: KeyAction.setNull).nullable()();
}
