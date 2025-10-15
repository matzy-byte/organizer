import 'package:isar/isar.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';
import 'package:organizer/data/isar_provider.dart';
import 'package:organizer/data/models/topic_isar.dart';
import 'package:organizer/data/models/var_transaction_isar.dart';

class VarTransactionRepositoryIsar implements VarTransactionRepository {
  @override
  Future<void> addVarTransaction(Topic topic,
    Polarity type,
    DateTime date,
    int value,
    Compensation compensation,
    String? description) async {
    final isar = await IsarProvider.instance;
    final ta = VarTransactionIsar()
      ..type = type
      ..date = date
      ..value = value
      ..compensation = compensation
      ..description = description;
    final tpc = await isar.topicIsars
        .filter()
        .idEqualTo(topic.id)
        .findFirst();
    ta.topic.value = tpc;
    await isar.writeTxn(() async {
      await isar.varTransactionIsars.put(ta);
      await ta.topic.save();
    });
  }

  @override
  Future<List<VarTransaction>> getAllVarTransactionsByTopic(Topic topic) async {
    final isar = await IsarProvider.instance;
    final tas = await isar.varTransactionIsars
        .filter()
        .topic((q) => q.idEqualTo(topic.id))
        .findAll();
    return tas
        .map(
          (t) => VarTransaction(
            id: t.id,
            topic: topic,
            type: t.type,
            date: t.date,
            value: t.value,
            compensation: t.compensation,
            description: t.description
          ),
        )
        .toList();
  }

  @override
  Future<void> removeVarTransaction(VarTransaction varTransaction) async {
    final isar = await IsarProvider.instance;
    await isar.writeTxn(() async {
      await isar.varTransactionIsars.delete(varTransaction.id);
    });
  }
}
