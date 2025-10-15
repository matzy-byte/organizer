import 'package:flutter/material.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/services/var_transaction_service.dart';

class VarTransactionProvider with ChangeNotifier {
  final VarTransactionService varTransactionService;

  VarTransactionProvider({required this.varTransactionService});

  Future<List<VarTransaction>> getAllVarTransactionsByTopic(Topic topic) async {
    return await varTransactionService.getAllVarTransactionsByTopic(topic);
  }

  Future<void> addVarTransaction(
    Topic topic,
    Polarity type,
    DateTime date,
    int value,
    Compensation compensation,
    String? description,
  ) async {
    await varTransactionService.addVarTransaction(
      topic,
      type,
      date,
      value,
      compensation,
      description,
    );
  }

  Future<void> removeTopic(VarTransaction varTransaction) async {
    await varTransactionService.removeVarTransaction(varTransaction);
  }
}
