import 'package:flutter/material.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/services/var_transaction_service.dart';

class VarTransactionProvider with ChangeNotifier {
  final VarTransactionService varTransactionService;

  int? _topicId;
  DateTime? _from;
  DateTime? _to;

  List<VarTransaction> _varTransactions = [];
  List<VarTransaction> get varTransactions => _varTransactions;

  VarTransactionProvider({required this.varTransactionService});

  Future<void> loadByCategory({
    required int categoryId,
    required DateTime from,
    required DateTime to,
  }) async {
    _from = from;
    _to = to;

    _varTransactions = await varTransactionService.getByDateForCategoryId(
      categoryId,
      from,
      to,
    );
    notifyListeners();
  }

  Future<void> loadByTopic({
    required int topicId,
    required DateTime from,
    required DateTime to,
  }) async {
    _topicId = topicId;
    _from = from;
    _to = to;

    _varTransactions = await varTransactionService.getByDateForTopicId(
      topicId,
      from,
      to,
    );
    notifyListeners();
  }

  Future<void> reload() async {
    if (_topicId == null) return;
    _varTransactions = await varTransactionService.getByDateForTopicId(
      _topicId!,
      _from!,
      _to!,
    );
    notifyListeners();
  }

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
    final newId = await varTransactionService.addVarTransaction(
      topicId,
      date,
      value,
      userRefId,
      compensations,
      transactionLabelId,
      description,
      fixRefId,
      varRefId,
      fileRefId,
    );
    await reload();
    return newId;
  }

  Future<void> removeVarTransaction(int id) async {
    await varTransactionService.removeVarTransaction(id);
    await reload();
  }

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
    await varTransactionService.updateVarTransaction(
      id,
      topicId,
      date,
      value,
      userRefId,
      compensations,
      transactionLabelId,
      description,
      fixRefId,
      varRefId,
      fileRefId,
    );
    await reload();
  }

  Future<void> setVarReference(int id, int refId) async {
    await varTransactionService.setVarReference(id, refId);
    await reload();
  }

  Future<VarTransaction> get(int id) async {
    return await varTransactionService.get(id);
  }
}
