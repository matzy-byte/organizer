import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/fix_transactions_repository.dart';

class FixTransactionService {
  final FixTransactionRepository repository;

  FixTransactionService(this.repository);

  Future<List<FixTransaction>> getAllFixTransactionsByTopic(Topic topic) async {
    final transactions = await repository.getAllFixTransactionsByTopic(topic);
    return transactions;
  }

  Future<void> addFixTransaction(
    Topic topic,
    Status status,
    Polarity type,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    Compensation compensation,
    String? description,
  ) => repository.addFixTransaction(
    topic,
    status,
    type,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    compensation,
    description,
  );
  Future<void> removeFixTransaction(FixTransaction fixTransaction) =>
      repository.removeFixTransaction(fixTransaction);
}
