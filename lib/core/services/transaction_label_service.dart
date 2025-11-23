import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/core/repositories/transaction_label_repository.dart';

class TransactionLabelService {
  final TransactionLabelRepository repository;

  TransactionLabelService(this.repository);

  Future<List<TransactionLabel>> getAllTransactionLabels() async {
    return await repository.getAllTransactionLabels();
  }

  Future<void> addTransactionLabel(String name, String color) async {
    await repository.addTransactionLabel(name, color);
  }

  Future<void> removeTransactionLabel(int id) async {
    await repository.removeTransactionLabel(id);
  }

  Future<void> updateTransactionLabel(int id, String name, String color) async {
    await repository.updateTransactionLabel(id, name, color);
  }
}
