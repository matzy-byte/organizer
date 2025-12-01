import 'package:drift/drift.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/repositories/fix_transactions_repository.dart';
import 'package:organizer/core/utils/json_util.dart';
import 'package:organizer/data/database/database.dart' hide FixTransaction;

class FixTransactionRepositoryDrift implements FixTransactionRepository {
  final AppDatabase db;
  FixTransactionRepositoryDrift(this.db);

  @override
  Future<int> addFixTransaction(
    int topicId,
    Status status,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    int userRefId,
    DateTime lastEdit,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
    int? fileRefId,
  ) async {
    return await db
        .into(db.fixTransactions)
        .insert(
          FixTransactionsCompanion.insert(
            topicId: topicId,
            status: status,
            start: start,
            end: end,
            intervalCount: intervalCount,
            intervalUnit: intervalUnit,
            value: value,
            userRefId: userRefId,
            lastEdit: lastEdit,
            compensations: compensations == null
                ? Value(null)
                : Value(JsonUtil.compensation2String(compensations)),
            transactionLabelId: Value(transactionLabelId),
            description: Value(description),
            latestDate: Value(latestDate),
            varRefId: Value(varRefId),
            fileRefId: Value(fileRefId),
          ),
        );
  }

  @override
  Future<List<FixTransaction>> getAllFixTransactions() async {
    final rows = await (db.select(db.fixTransactions)).get();
    return rows
        .map(
          (f) => FixTransaction(
            id: f.id,
            topicId: f.topicId,
            status: f.status,
            start: f.start,
            end: f.end,
            intervalCount: f.intervalCount,
            intervalUnit: f.intervalUnit,
            value: f.value,
            userRefId: f.userRefId,
            lastEdit: f.lastEdit,
            compensations: JsonUtil.string2CompensationInfo(f.compensations),
            transactionLabelId: f.transactionLabelId,
            description: f.description,
            latestDate: f.latestDate,
            varRefId: f.varRefId,
            fileRefId: f.fileRefId,
          ),
        )
        .toList();
  }

  @override
  Future<List<FixTransaction>> getAllFixTransactionsByTopicId(
    int topicId,
  ) async {
    final rows = await (db.select(
      db.fixTransactions,
    )..where((f) => f.topicId.equals(topicId))).get();
    return rows
        .map(
          (f) => FixTransaction(
            id: f.id,
            topicId: f.topicId,
            status: f.status,
            start: f.start,
            end: f.end,
            intervalCount: f.intervalCount,
            intervalUnit: f.intervalUnit,
            value: f.value,
            userRefId: f.userRefId,
            lastEdit: f.lastEdit,
            compensations: JsonUtil.string2CompensationInfo(f.compensations),
            transactionLabelId: f.transactionLabelId,
            description: f.description,
            latestDate: f.latestDate,
            varRefId: f.varRefId,
            fileRefId: f.fileRefId,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteFixTransaction(int id) async {
    await db.transaction(() async {
      final varTransactions = await (db.select(
        db.varTransactions,
      )..where((v) => v.fixRefId.equals(id))).get();

      for (final v in varTransactions) {
        if (v.compensations != null) {
          final compensations = JsonUtil.string2CompensationInfo(
            v.compensations,
          )!;
          for (final cId in compensations.keys) {
            await (db.delete(
              db.varTransactions,
            )..where((vT) => vT.id.equals(cId))).go();
          }
        }

        await (db.delete(
          db.varTransactions,
        )..where((vItem) => vItem.id.equals(v.id))).go();
      }

      await (db.delete(db.fixTransactions)..where((f) => f.id.equals(id))).go();
    });
  }

  @override
  Future<void> updateFixTransaction(
    int id,
    int topicId,
    Status status,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    int userRefId,
    DateTime lastEdit,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
    int? fileRefId,
  ) async {
    await (db.update(db.fixTransactions)..where((v) => v.id.equals(id))).write(
      FixTransactionsCompanion(
        id: Value(id),
        topicId: Value(topicId),
        status: Value(status),
        start: Value(start),
        end: Value(end),
        intervalCount: Value(intervalCount),
        intervalUnit: Value(intervalUnit),
        value: Value(value),
        userRefId: Value(userRefId),
        lastEdit: Value(lastEdit),
        compensations: Value(JsonUtil.compensation2String(compensations)),
        transactionLabelId: Value(transactionLabelId),
        description: Value(description),
        latestDate: Value(latestDate),
        varRefId: Value(varRefId),
        fileRefId: Value(fileRefId),
      ),
    );
  }
}
