import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';

abstract class VarTransactionRepository {
  Future<List<VarTransaction>> getAllVarTransactionsByTopic(Topic topic);
  Future<int> addVarTransaction(
    Topic topic,
    Polarity type,
    DateTime date,
    int value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    FixTransaction? fixReference
  );
  Future<void> removeVarTransaction(VarTransaction varTransaction);
}
