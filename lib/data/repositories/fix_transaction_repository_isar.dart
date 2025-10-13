import 'package:isar/isar.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/repositories/fix_transactions_repository.dart';
import 'package:organizer/data/isar_provider.dart';
import 'package:organizer/data/models/fix_transaction_isar.dart';
import 'package:organizer/data/models/topic_isar.dart';

class FixTransactionRepositoryIsar implements FixTransactionRepository {
  @override
  Future<void> addFixTransaction(
    Topic topic,
    Status status,
    Polarity type,
    DateTime start,
    DateTime end,
    int interval,
    int value,
    Compensation compensation,
    String? description,
  ) async {
    final isar = await IsarProvider.instance;
    final ta = FixTransactionIsar()
      ..status = status
      ..type = type
      ..start = start
      ..end = end
      ..interval = interval
      ..value = value
      ..compensation = compensation
      ..description = description;
    final tpc = await isar.topicIsars.filter().idEqualTo(topic.id).findFirst();
    ta.topic.value = tpc;
    await isar.writeTxn(() async {
      await isar.fixTransactionIsars.put(ta);
      await ta.topic.save();
    });
  }

  @override
  Future<List<FixTransaction>> getAllFixTransactionsByTopic(Topic topic) async {
    final isar = await IsarProvider.instance;
    final tas = await isar.fixTransactionIsars
        .filter()
        .topic((q) => q.idEqualTo(topic.id))
        .findAll();
    return tas
        .map(
          (t) => FixTransaction(
            id: t.id,
            topic: topic,
            status: t.status,
            type: t.type,
            start: t.start,
            end: t.end,
            interval: t.interval,
            value: t.value,
            compensation: t.compensation,
            description: t.description,
          ),
        )
        .toList();
  }

  @override
  Future<void> removeFixTransaction(FixTransaction fixTransaction) async {
    final isar = await IsarProvider.instance;
    await isar.writeTxn(() async {
      await isar.fixTransactionIsars.delete(fixTransaction.id);
    });
  }
}
