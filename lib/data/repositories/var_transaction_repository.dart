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
    int userRefId,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
    int? fileRefId,
  ) async {
    int id = await db
        .into(db.varTransactions)
        .insert(
          VarTransactionsCompanion.insert(
            topicId: topicId,
            date: date,
            value: value,
            userRefId: userRefId,
            compensations: compensations == null
                ? Value(null)
                : Value(JsonUtil.compensation2String(compensations)),
            transactionLabelId: Value(transactionLabelId),
            description: Value(description),
            fixRefId: Value(fixRefId),
            varRefId: Value(varRefId),
            fileRefId: Value(fileRefId),
          ),
        );
    return id;
  }

  @override
  Future<List<VarTransaction>> getByDateForCategoryId(
    int categoryId,
    DateTime from,
    DateTime to,
  ) async {
    final topics = await (db.select(db.topics)..where((t) => t.categoryId.equals(categoryId))).get();
    final topicIds = topics.map((t) => t.id).toList();
    final rows =
        await (db.select(db.varTransactions)..where(
              (v) =>
                  v.topicId.isIn(topicIds) & v.date.isBetweenValues(from, to),
            ))
            .get();
    return rows
        .map(
          (v) => VarTransaction(
            id: v.id,
            topicId: v.topicId,
            date: v.date,
            value: v.value,
            userRefId: v.userRefId,
            compensations: JsonUtil.string2CompensationInfo(v.compensations),
            transactionLabelId: v.transactionLabelId,
            description: v.description,
            fixRefId: v.fixRefId,
            varRefId: v.varRefId,
            fileRefId: v.fileRefId,
          ),
        )
        .toList();
  }

  @override
  Future<List<VarTransaction>> getByDateForTopicId(
    int topicId,
    DateTime from,
    DateTime to,
  ) async {
    final rows =
        await (db.select(db.varTransactions)..where(
              (v) =>
                  v.topicId.equals(topicId) & v.date.isBetweenValues(from, to),
            ))
            .get();
    return rows
        .map(
          (v) => VarTransaction(
            id: v.id,
            topicId: v.topicId,
            date: v.date,
            value: v.value,
            userRefId: v.userRefId,
            compensations: JsonUtil.string2CompensationInfo(v.compensations),
            transactionLabelId: v.transactionLabelId,
            description: v.description,
            fixRefId: v.fixRefId,
            varRefId: v.varRefId,
            fileRefId: v.fileRefId,
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
    int? userRefId,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
    int? fileRefId,
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
        fixRefId: fixRefId == null ? Value(row.fixRefId) : Value(fixRefId),
        varRefId: varRefId == null ? Value(row.varRefId) : Value(varRefId),
        fileRefId: fileRefId == null ? Value(row.fileRefId) : Value(fileRefId),
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
      userRefId: row.userRefId,
      compensations: JsonUtil.string2CompensationInfo(row.compensations),
      transactionLabelId: row.transactionLabelId,
      description: row.description,
      fixRefId: row.fixRefId,
      varRefId: row.varRefId,
    );
  }
}
