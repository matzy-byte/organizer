import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';

class VarTransactionService {
  final VarTransactionRepository repository;

  VarTransactionService(this.repository);

  Future<List<VarTransaction>> getAllVarTransactionsByTopicId(
    int topicId,
  ) async {
    final transactions = await repository.getAllVarTransactionsByTopicId(
      topicId,
    );
    return transactions;
  }

  Future<int> addVarTransaction(
    int topicId,
    DateTime date,
    int value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    int? fixRefId,
    int? varRefId,
  ) => repository.addVarTransaction(
    topicId,
    date,
    value,
    compensations,
    description,
    fixRefId,
    varRefId,
  );
  Future<void> removeVarTransaction(int id) =>
      repository.removeVarTransaction(id);

  Future<void> updateVarTransaction(VarTransaction varTransaction) =>
      repository.updateVarTransaction(varTransaction);

  Future<void> setVarReference(int id, int refId) =>
      repository.setVarReference(id, refId);
}
