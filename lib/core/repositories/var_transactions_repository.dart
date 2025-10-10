import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';

abstract class VarTransactionRepository {
  Future<List<VarTransaction>> getAllVarTransactionsByTopic(Topic topic);
  Future<void> addVarTransaction(VarTransaction varTransaction);
  Future<void> removeVarTransaction(int id);
}