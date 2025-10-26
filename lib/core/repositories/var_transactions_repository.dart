import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';

abstract class VarTransactionRepository {
  Future<List<VarTransaction>> getAllVarTransactionsByTopicId(int topicId);
  Future<int> addVarTransaction(
    int topicId,
    DateTime date,
    int value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    int? fixRefId,
    int? varRefId,
  );
  Future<void> removeVarTransaction(int id);
  Future<void> updateVarTransaction(
    int id,
    int? topicId,
    DateTime? date,
    int? value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    int? fixRefId,
    int? varRefId,
  );
  Future<void> setVarReference(int id, int varRefId);
}
