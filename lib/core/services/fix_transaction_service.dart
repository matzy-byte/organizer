import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/repositories/fix_transactions_repository.dart';

class FixTransactionService {
  final FixTransactionRepository repository;

  FixTransactionService(this.repository);

  Future<List<FixTransaction>> getAllFixTransactionsByTopicId(
    int topicId,
  ) async {
    final transactions = await repository.getAllFixTransactionsByTopicId(
      topicId,
    );
    return transactions;
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
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
  ) => repository.addFixTransaction(
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    compensations,
    transactionLabelId,
    description,
    latestDate,
    varRefId,
  );
  Future<void> removeFixTransaction(int id) =>
      repository.removeFixTransaction(id);
  Future<void> updateFixTransaction(
    int id,
    int? topicId,
    Status? status,
    DateTime? start,
    DateTime? end,
    int? intervalCount,
    IntervalUnit? intervalUnit,
    int? value,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
  ) => repository.updateFixTransaction(
    id,
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    compensations,
    transactionLabelId,
    description,
    latestDate,
    varRefId,
  );
}
