import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';

class VarTransactionService {
  final VarTransactionRepository repository;

  VarTransactionService(this.repository);

  Future<List<VarTransaction>> loadVarTransactionsByTopic(Topic topic) async {
    final transactions = await repository.getAllVarTransactionsByTopic(topic);
    return transactions;
  }

  Future<void> addVarTransaction(VarTransaction varTransaction) =>
      repository.addVarTransaction(varTransaction);
  Future<void> removeVarTransaction(int id) =>
      repository.removeVarTransaction(id);
}