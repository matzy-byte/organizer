import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/topic.dart';

abstract class FixTransactionRepository {
  Future<List<FixTransaction>> getAllFixTransactionsByTopic(Topic topic);
  Future<void> addFixTransaction(FixTransaction fixTransaction);
  Future<void> removeFixTransaction(int id);
}