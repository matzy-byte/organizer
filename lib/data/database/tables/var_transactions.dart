import 'package:drift/drift.dart';
import 'package:organizer/data/database/tables/fix_transactions.dart';
import 'package:organizer/data/database/tables/topics.dart';
import 'package:organizer/data/database/tables/transaction_labels.dart';

class VarTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get topicId => integer().references(Topics, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get value => integer()();
  TextColumn get compensations => text().nullable()();
  IntColumn get transactionLabelId =>
      integer().references(TransactionLabels, #id).nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get fixRefId =>
      integer().references(FixTransactions, #id).nullable()();
  IntColumn get varRefId =>
      integer().references(VarTransactions, #id).nullable()();
}
