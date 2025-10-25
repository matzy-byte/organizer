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
    Map<int, CompensationInfo>? compensations,
    String? description,
  );
  Future<void> removeFixTransaction(int id);
}
