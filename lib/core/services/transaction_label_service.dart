import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/core/repositories/transaction_label_repository.dart';

class TransactionLabelService {
  final TransactionLabelRepository repository;

  TransactionLabelService(this.repository);

  Future<List<TransactionLabel>> getAllTransactionLabels() async {
    return await repository.getAllTransactionLabels();
  }

  Future<void> addTransactionLabel(
    String name,
    String color,
    DateTime lastEdit,
  ) async {
    await repository.addTransactionLabel(name, color, lastEdit);
  }

  Future<void> deleteTransactionLabel(int id) async {
    await repository.deleteTransactionLabel(id);
  }

  Future<void> updateTransactionLabel(
    int id,
    String name,
    String color,
    DateTime lastEdit,
  ) async {
    await repository.updateTransactionLabel(id, name, color, lastEdit);
  }
}
