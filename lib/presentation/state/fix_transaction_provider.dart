import 'package:flutter/material.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/services/fix_transaction_service.dart';

class FixTransactionProvider with ChangeNotifier {
  final FixTransactionService fixTransactionService;

  int? _topicId;
  List<FixTransaction> _fixTransactions = [];
  List<FixTransaction> get fixTransactions => _fixTransactions;

  FixTransactionProvider({required this.fixTransactionService});

  Future<void> loadByTopic(int topicId) async {
    _topicId = topicId;
    _fixTransactions = await fixTransactionService
        .getAllFixTransactionsByTopicId(topicId);

    notifyListeners();
  }

  Future<void> reload() async {
    if (_topicId == null) return;

    _fixTransactions = await fixTransactionService
        .getAllFixTransactionsByTopicId(_topicId!);

    notifyListeners();
  }

  Future<int> addFixTransaction(
    int topicId,
    Status status,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    int userRefId,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
    int? fileRefId,
  ) async {
    final id = await fixTransactionService.addFixTransaction(
      topicId,
      status,
      start,
      end,
      intervalCount,
      intervalUnit,
      value,
      userRefId,
      compensations,
      transactionLabelId,
      description,
      latestDate,
      varRefId,
      fileRefId,
    );

    await reload();
    return id;
  }

  Future<void> removeFixTransaction(int id) async {
    await fixTransactionService.removeFixTransaction(id);
    await reload();
  }

  Future<void> updateFixTransaction(
    int id,
    int? topicId,
    Status? status,
    DateTime? start,
    DateTime? end,
    int? intervalCount,
    IntervalUnit? intervalUnit,
    int? value,
    int? userRefId,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
    int? fileRefId,
  ) async {
    await fixTransactionService.updateFixTransaction(
      id,
      topicId,
      status,
      start,
      end,
      intervalCount,
      intervalUnit,
      value,
      userRefId,
      compensations,
      transactionLabelId,
      description,
      latestDate,
      varRefId,
      fileRefId,
    );

    await reload();
  }
}
