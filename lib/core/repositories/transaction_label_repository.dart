import 'package:organizer/core/models/transaction_label.dart';

abstract class TransactionLabelRepository {
  Future<List<TransactionLabel>> getAllTransactionLabels();
  Future<void> addTransactionLabel(String name);
  Future<void> removeTransactionLabel(int id);
  Future<void> updateTransactionLabel(int id, String name);
}
