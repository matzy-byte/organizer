import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';

abstract class FixTransactionRepository {
  Future<List<FixTransaction>> getAllFixTransactionsByTopic(Topic topic);
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
  );
  Future<void> removeFixTransaction(FixTransaction fixTransaction);
}
