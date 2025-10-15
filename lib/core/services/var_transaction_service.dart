import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';

class VarTransactionService {
  final VarTransactionRepository repository;

  VarTransactionService(this.repository);

  Future<List<VarTransaction>> getAllVarTransactionsByTopic(Topic topic) async {
    final transactions = await repository.getAllVarTransactionsByTopic(topic);
    return transactions;
  }

  Future<void> addVarTransaction(
    Topic topic,
    Polarity type,
    DateTime date,
    int value,
    Compensation compensation,
    String? description,
  ) => repository.addVarTransaction(
    topic,
    type,
    date,
    value,
    compensation,
    description,
  );
  Future<void> removeVarTransaction(VarTransaction varTransaction) =>
      repository.removeVarTransaction(varTransaction);
}