import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/fix_transactions_repository.dart';

class FixTransactionService {
  final FixTransactionRepository repository;

  FixTransactionService(this.repository);

  Future<List<FixTransaction>> loadFixTransactionsByTopic(Topic topic) async {
    final transactions = await repository.getAllFixTransactionsByTopic(topic);
    return transactions;
  }

  Future<void> addFixTransaction(FixTransaction fixTransaction) =>
      repository.addFixTransaction(fixTransaction);
  Future<void> removeFixTransaction(int id) =>
      repository.removeFixTransaction(id);
}
