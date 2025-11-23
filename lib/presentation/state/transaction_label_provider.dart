import 'package:flutter/material.dart';
import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/core/services/transaction_label_service.dart';

class TransactionLabelProvider with ChangeNotifier {
  final TransactionLabelService transactionLabelService;
  List<TransactionLabel> _transactionLabels = [];
  List<TransactionLabel> get transactionLabels => _transactionLabels;

  TransactionLabelProvider({required this.transactionLabelService});

  Future<void> loadAllTransactionLabels() async {
    _transactionLabels = await getAllTransactionLabels();
    notifyListeners();
  }

  Future<List<TransactionLabel>> getAllTransactionLabels() async {
    return await transactionLabelService.getAllTransactionLabels();
  }
  Future<void> addTransactionLabel(String name, String color) async {
    await transactionLabelService.addTransactionLabel(name, color);
    await loadAllTransactionLabels();
  }
  Future<void> removeTransactionLabel(int id) async {
    await transactionLabelService.removeTransactionLabel(id);
    await loadAllTransactionLabels();
  }
  Future<void> updateTransactionLabel(int id, String name, String color) async {
    await transactionLabelService.updateTransactionLabel(id, name, color);
    await loadAllTransactionLabels();
  }
}