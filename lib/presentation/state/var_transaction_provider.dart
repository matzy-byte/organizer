import 'package:flutter/material.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/services/var_transaction_service.dart';

class VarTransactionProvider with ChangeNotifier {
  final VarTransactionService varTransactionService;

  VarTransactionProvider({required this.varTransactionService});

  Future<List<VarTransaction>> getAllVarTransactionsByTopicId(
    int topicId,
  ) async {
    return await varTransactionService.getAllVarTransactionsByTopicId(topicId);
  }

  Future<int> addVarTransaction(
    int topicId,
    DateTime date,
    int value,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
  ) async {
    return await varTransactionService.addVarTransaction(
      topicId,
      date,
      value,
      compensations,
      transactionLabelId,
      description,
      fixRefId,
      varRefId,
    );
  }

  Future<void> removeVarTransaction(int id) async {
    await varTransactionService.removeVarTransaction(id);
  }

  Future<void> updateVarTransaction(
    int id,
    int? topicId,
    DateTime? date,
    int? value,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
  ) async {
    await varTransactionService.updateVarTransaction(
      id,
      topicId,
      date,
      value,
      compensations,
      transactionLabelId,
      description,
      fixRefId,
      varRefId,
    );
  }

  Future<void> setVarReference(int id, int refId) async {
    await varTransactionService.setVarReference(id, refId);
  }

  Future<VarTransaction> get(int id) async {
    return await varTransactionService.get(id);
  }
}
