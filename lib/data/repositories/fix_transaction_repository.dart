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
  Future<void> removeFixTransaction(int id) async {
    await (db.delete(db.fixTransactions)..where((f) => f.id.equals(id))).go();
  }

  @override
  Future<void> updateFixTransaction(
    int id,
    int? topicId,
    Status? status,
    DateTime? start,
    DateTime? end,
    int? intervalCount,
    IntervalUnit? intervalUnit,
    int? value,
    int? userRefId,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
    int? fileRefId,
  ) async {
    final row = await (db.select(
      db.fixTransactions,
    )..where((v) => v.id.equals(id))).getSingle();
    await (db.update(db.fixTransactions)..where((v) => v.id.equals(id))).write(
      FixTransactionsCompanion(
        id: Value(id),
        topicId: topicId == null ? Value(row.topicId) : Value(topicId),
        status: status == null ? Value(row.status) : Value(status),
        start: start == null ? Value(row.start) : Value(start),
        end: end == null ? Value(row.end) : Value(end),
        intervalCount: intervalCount == null
            ? Value(row.intervalCount)
            : Value(intervalCount),
        intervalUnit: intervalUnit == null
            ? Value(row.intervalUnit)
            : Value(intervalUnit),
        value: value == null ? Value(row.value) : Value(value),
        userRefId: userRefId == null ? Value(row.userRefId) : Value(userRefId),
        compensations: compensations == null
            ? Value(row.compensations)
            : Value(JsonUtil.compensation2String(compensations)),
        transactionLabelId: transactionLabelId == null
            ? Value(row.transactionLabelId)
            : Value(transactionLabelId),
        description: description == null
            ? Value(row.description)
            : Value(description),
        latestDate: latestDate == null
            ? Value(row.latestDate)
            : Value(latestDate),
        varRefId: varRefId == null ? Value(row.varRefId) : Value(varRefId),
        fileRefId: fileRefId == null ? Value(row.fileRefId) : Value(fileRefId),
      ),
    );
  }
}
