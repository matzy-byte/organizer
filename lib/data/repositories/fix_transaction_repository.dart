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
  Future<void> addFixTransaction(
    int topicId,
    Status status,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    int? varRefId,
    DateTime? latestDate,
  ) async {
    await db
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
            compensations: compensations == null ? Value(null) : Value(JsonUtil.compensation2String(compensations)),
            decription: Value(description),
            latestDate: Value(latestDate),
            varRefId: Value(varRefId),
          ),
        );
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
            compensations: JsonUtil.string2CompensationInfo(f.compensations),
            description: f.decription,
            latestDate: f.latestDate,
            varRefId: f.varRefId,
          ),
        )
        .toList();
  }

  @override
  Future<void> removeFixTransaction(int id) async {
    await (db.delete(db.fixTransactions)..where((f) => f.id.equals(id))).go();
  }
}
