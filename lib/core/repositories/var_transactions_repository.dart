import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';

abstract class VarTransactionRepository {
  Future<int> addVarTransaction(
    int topicId,
    DateTime date,
    int value,
    int userRefId,
    DateTime lastEdit,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
    int? fileRefId,
  );
  Future<void> deleteVarTransaction(int id);
  Future<void> updateVarTransaction(
    int id,
    int topicId,
    DateTime date,
    int value,
    int userRefId,
    DateTime lastEdit,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    int? fixRefId,
    int? varRefId,
    int? fileRefId,
  );
  Future<void> setVarReference(int id, int varRefId);
  Future<VarTransaction> get(int id);
  Future<List<VarTransaction>> getByDateForTopicId(
    int topicId,
    DateTime from,
    DateTime to,
  );
  Future<List<VarTransaction>> getByDateForCategoryId(
    int categoryId,
    DateTime from,
    DateTime to,
  );
  Future<List<VarTransaction>> getByDate(DateTime from, DateTime to);
}
