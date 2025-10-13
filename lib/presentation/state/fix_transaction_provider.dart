import 'package:flutter/material.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/services/fix_transaction_service.dart';

class FixTransactionProvider with ChangeNotifier {
  final FixTransactionService fixTransactionService;

  FixTransactionProvider({required this.fixTransactionService});

  Future<List<FixTransaction>> getAllFixTransactionsByTopic(Topic topic) async {
    return await fixTransactionService.getAllFixTransactionsByTopic(topic);
  }

  Future<void> addTopic(
    Topic topic,
    Status status,
    Polarity type,
    DateTime start,
    DateTime end,
    int interval,
    int value,
    Compensation compensation,
    String? description,
  ) async {
    await fixTransactionService.addFixTransaction(
      topic,
      status,
      type,
      start,
      end,
      interval,
      value,
      compensation,
      description,
    );
  }

  Future<void> removeTopic(FixTransaction fixTransaction) async {
    await fixTransactionService.removeFixTransaction(fixTransaction);
  }
}
