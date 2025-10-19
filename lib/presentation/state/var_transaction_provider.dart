import 'package:flutter/material.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
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

  Future<int> addVarTransaction(
    Topic topic,
    Polarity type,
    DateTime date,
    int value,
    Map<int, CompensationInfo>? compensation,
    String? description,
    FixTransaction? fixReference,
  ) async {
    return await varTransactionService.addVarTransaction(
      topic,
      type,
      date,
      value,
      compensation,
      description,
      fixReference,
    );
  }

  Future<void> removeTopic(VarTransaction varTransaction) async {
    await varTransactionService.removeVarTransaction(varTransaction);
  }
}
