import 'package:drift/drift.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';
import 'package:organizer/core/utils/json_util.dart';
import 'package:organizer/data/database/database.dart' hide VarTransaction;

class VarTransactionRepositoryDrift implements VarTransactionRepository {
  AppDatabase db;
  VarTransactionRepositoryDrift(this.db);

  @override
  Future<int> addVarTransaction(
    int topicId,
    DateTime date,
    int value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    int? fixRefId,
    int? varRefId,
  ) async {
    int id = await db
        .into(db.varTransactions)
        .insert(
          VarTransactionsCompanion.insert(
            topicId: topicId,
            date: date,
            value: value,
            compensations: compensations == null
                ? Value(null)
                : Value(JsonUtil.compensation2String(compensations)),
            description: Value(description),
            fixRefId: Value(fixRefId),
            varRefId: Value(varRefId),
          ),
        );
    return id;
  }

  @override
  Future<List<VarTransaction>> getAllVarTransactionsByTopicId(
    int topicId,
  ) async {
    final rows = await (db.select(
      db.varTransactions,
    )..where((v) => v.topicId.equals(topicId))).get();
    return rows
        .map(
          (v) => VarTransaction(
            id: v.id,
            topicId: v.topicId,
            date: v.date,
            value: v.value,
            compensations: JsonUtil.string2CompensationInfo(v.compensations),
            description: v.description,
            fixRefId: v.fixRefId,
            varRefId: v.varRefId,
          ),
        )
        .toList();
  }

  @override
  Future<void> removeVarTransaction(int id) async {
    final row = await (db.select(
      db.varTransactions,
    )..where((v) => v.id.equals(id))).getSingle();
    if (row.varRefId != null) {
      final ref = await (db.select(
        db.varTransactions,
      )..where((v) => v.id.equals(row.varRefId!))).getSingle();
      final compensations = JsonUtil.string2CompensationInfo(ref.compensations);
      if (compensations != null) {
        compensations.removeWhere((key, value) => key == row.id);
        final comps = compensations.isEmpty ? null : compensations;
        await (db.update(
          db.varTransactions,
        )..where((v) => v.id.equals(ref.id))).write(
          VarTransactionsCompanion(
            compensations: Value(JsonUtil.compensation2String(comps)),
          ),
        );
      }
    }
    if (row.compensations != null) {
      final compensations = JsonUtil.string2CompensationInfo(row.compensations);
      if (compensations != null) {
        for (final compId in compensations.keys) {
          await (db.delete(
            db.varTransactions,
          )..where((v) => v.id.equals(compId))).go();
        }
      }
    }
    await (db.delete(db.varTransactions)..where((v) => v.id.equals(id))).go();
  }

  @override
  Future<void> updateVarTransaction(
    int id,
    int? topicId,
    DateTime? date,
    int? value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    int? fixRefId,
    int? varRefId,
  ) async {
    final row = await (db.select(
      db.varTransactions,
    )..where((v) => v.id.equals(id))).getSingle();
    await (db.update(db.varTransactions)..where((v) => v.id.equals(id))).write(
      VarTransactionsCompanion(
        id: Value(id),
        topicId: topicId == null ? Value(row.topicId) : Value(topicId),
        date: date == null ? Value(row.date) : Value(date),
        value: value == null ? Value(row.value) : Value(value),
        compensations: compensations == null
            ? Value(row.compensations)
            : Value(JsonUtil.compensation2String(compensations)),
        description: description == null
            ? Value(row.description)
            : Value(description),
        fixRefId: fixRefId == null ? Value(row.fixRefId) : Value(fixRefId),
        varRefId: varRefId == null ? Value(row.varRefId) : Value(varRefId),
      ),
    );
    final updatedRow = await (db.select(
      db.varTransactions,
    )..where((v) => v.id.equals(id))).getSingle();
    if (updatedRow.varRefId != null) {
      final ref = await (db.select(
        db.varTransactions,
      )..where((v) => v.id.equals(row.varRefId!))).getSingle();
      final compensations = JsonUtil.string2CompensationInfo(ref.compensations);
      if (compensations != null) {
        final topic = await (db.select(
          db.topics,
        )..where((t) => t.id.equals(updatedRow.topicId))).getSingle();
        compensations[id] = CompensationInfo(
          topicId: topic.id,
          topicName: topic.name,
          value: updatedRow.value,
        );
        final comps = compensations.isEmpty ? null : compensations;
        await (db.update(
          db.varTransactions,
        )..where((v) => v.id.equals(ref.id))).write(
          VarTransactionsCompanion(
            compensations: Value(JsonUtil.compensation2String(comps)),
          ),
        );
      }
    }
  }

  @override
  Future<void> setVarReference(int id, int refId) async {
    await (db.update(db.varTransactions)..where((v) => v.id.equals(id))).write(
      VarTransactionsCompanion(varRefId: Value(refId)),
    );
  }

  @override
  Future<VarTransaction> get(int id) async {
    final row = await (db.select(
      db.varTransactions,
    )..where((v) => v.id.equals(id))).getSingle();
    return VarTransaction(
      id: id,
      topicId: row.topicId,
      date: row.date,
      value: row.value,
      compensations: JsonUtil.string2CompensationInfo(row.compensations),
      description: row.description,
      fixRefId: row.fixRefId,
      varRefId: row.varRefId,
    );
  }
}
