import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';

abstract class FixTransactionRepository {
  Future<List<FixTransaction>> getAllFixTransactionsByTopicId(int id);
  Future<void> addFixTransaction(
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
  );
  Future<void> removeFixTransaction(int id);
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
  );
}
