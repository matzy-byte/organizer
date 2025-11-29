import 'package:drift/drift.dart';
import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/core/repositories/transaction_label_repository.dart';
import 'package:organizer/data/database/database.dart' hide TransactionLabel;

class TransactionLabellRepositoryDrift extends TransactionLabelRepository {
  final AppDatabase db;
  TransactionLabellRepositoryDrift(this.db);

  @override
  Future<void> addTransactionLabel(String name, String color) async {
    await db
        .into(db.transactionLabels)
        .insert(
          TransactionLabelsCompanion.insert(
            name: name,
            color: color,
            lastEdit: DateTime.now(),
          ),
        );
  }

  @override
  Future<List<TransactionLabel>> getAllTransactionLabels() async {
    final rows = await (db.select(db.transactionLabels)).get();
    return rows
        .map((t) => TransactionLabel(t.id, t.name, t.color, t.lastEdit))
        .toList();
  }

  @override
  Future<void> removeTransactionLabel(int id) async {
    await (db.delete(db.transactionLabels)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> updateTransactionLabel(int id, String name, String color) async {
    await (db.update(
      db.transactionLabels,
    )..where((t) => t.id.equals(id))).write(
      TransactionLabelsCompanion(
        id: Value(id),
        name: Value(name),
        color: Value(color),
        lastEdit: Value(DateTime.now()),
      ),
    );
  }
}
