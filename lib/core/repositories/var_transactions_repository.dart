import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';

abstract class VarTransactionRepository {
  Future<List<VarTransaction>> getAllVarTransactionsByTopicId(int topicId);
  Future<int> addVarTransaction(
    int topicId,
    DateTime date,
    int value,
    int userRefId,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
    int? fileRefId,
  );
  Future<void> removeVarTransaction(int id);
  Future<void> updateVarTransaction(
    int id,
    int? topicId,
    DateTime? date,
    int? value,
    int? userRefId,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
    int? fileRefId,
  );
  Future<void> setVarReference(int id, int varRefId);
  Future<VarTransaction> get(int id);
}
