import 'package:organizer/core/models/transaction_label.dart';

abstract class TransactionLabelRepository {
  Future<List<TransactionLabel>> getAllTransactionLabels();
  Future<void> addTransactionLabel(String name, String color);
  Future<void> removeTransactionLabel(int id);
  Future<void> updateTransactionLabel(int id, String name, String color);
}
