import 'package:flutter/material.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/services/fix_transaction_service.dart';

class FixTransactionProvider with ChangeNotifier {
  final FixTransactionService fixTransactionService;

  FixTransactionProvider({required this.fixTransactionService});

  Future<List<FixTransaction>> getAllFixTransactionsByTopicId(int topicId) async {
    return await fixTransactionService.getAllFixTransactionsByTopicId(topicId);
  }

  Future<void> addFixTransaction(
    int topicId,
    Status status,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    DateTime? latestDate,
    int? varRefId,
  ) async {
    await fixTransactionService.addFixTransaction(
      topicId,
      status,
      start,
      end,
      intervalCount,
      intervalUnit,
      value,
      compensations,
      description,
      latestDate,
      varRefId,
    );
  }

  Future<void> removeFixTransaction(int id) async {
    await fixTransactionService.removeFixTransaction(id);
  }
}
