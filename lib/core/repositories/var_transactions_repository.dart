import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';

abstract class VarTransactionRepository {
  Future<List<VarTransaction>> getAllVarTransactionsByTopic(Topic topic);
  Future<void> addVarTransaction(
    Topic topic,
    Polarity type,
    DateTime date,
    int value,
    Compensation compensation,
    String? description,
  );
  Future<void> removeVarTransaction(VarTransaction varTransaction);
}
