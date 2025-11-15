import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';

class VarTransactionService {
  final VarTransactionRepository repository;

  VarTransactionService(this.repository);

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
  ) => repository.addVarTransaction(
    topicId,
    date,
    value,
    userRefId,
    compensations,
    transactionLabelId,
    description,
    fixRefId,
    varRefId,
    fileRefId,
  );
  Future<void> removeVarTransaction(int id) =>
      repository.removeVarTransaction(id);

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
  ) => repository.updateVarTransaction(
    id,
    topicId,
    date,
    value,
    userRefId,
    compensations,
    transactionLabelId,
    description,
    fixRefId,
    varRefId,
    fileRefId,
  );

  Future<void> setVarReference(int id, int refId) =>
      repository.setVarReference(id, refId);

  Future<VarTransaction> get(int id) => repository.get(id);

  Future<List<VarTransaction>> getByDateForTopicId(
    int topicId,
    DateTime from,
    DateTime to,
  ) => repository.getByDateForTopicId(topicId, from, to);

  Future<List<VarTransaction>> getByDateForCategoryId(
    int categoryId,
    DateTime from,
    DateTime to,
  ) => repository.getByDateForCategoryId(categoryId, from, to);

  Future<List<VarTransaction>> getByDate(
    DateTime from,
    DateTime to,
  ) => repository.getByDate(from, to);
}
