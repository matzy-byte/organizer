import 'package:isar/isar.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';
import 'package:organizer/core/utils/json_util.dart';
import 'package:organizer/data/isar_provider.dart';
import 'package:organizer/data/models/fix_transaction_isar.dart';
import 'package:organizer/data/models/topic_isar.dart';
import 'package:organizer/data/models/var_transaction_isar.dart';

class VarTransactionRepositoryIsar implements VarTransactionRepository {
  @override
  Future<int> addVarTransaction(Topic topic,
    Polarity type,
    DateTime date,
    int value,
    Map<int, CompensationInfo>? compensations,
    String? description,
    FixTransaction? fixReference) async {
    final isar = await IsarProvider.instance;
    final ta = VarTransactionIsar()
      ..type = type
      ..date = date
      ..value = value
      ..compensations = JsonUtil.compensation2String(compensations)
      ..description = description;
    final tpc = await isar.topicIsars.get(topic.id);
    if (tpc != null) {
      ta.topic.value = tpc;
    }
    if (fixReference != null) {
      final fr = await isar.fixTransactionIsars.get(fixReference.id);
      if (fr != null) {
        ta.fixReference.value = fr;
      }
    }
    int id = -1;
    await isar.writeTxn(() async {
      id = await isar.varTransactionIsars.put(ta);
      await ta.topic.save();
      await ta.fixReference.save();
    });
    return id;
  }

  @override
  Future<List<VarTransaction>> getAllVarTransactionsByTopic(Topic topic) async {
    final isar = await IsarProvider.instance;
    final tas = await isar.varTransactionIsars
        .filter()
        .topic((t) => t.idEqualTo(topic.id))
        .findAll();
    await Future.wait(tas.map((t) async {
      await t.fixReference.load();
    }));
    return tas
        .map(
          (t) {
            final fr = t.fixReference.value;
            return VarTransaction(
              id: t.id,
              topic: topic,
              type: t.type,
              date: t.date,
              value: t.value,
              compensations: JsonUtil.string2CompensationInfo(t.compensations),
              description: t.description,
              fixReference: fr == null ? null : FixTransaction(id: fr.id, topic: topic, status: fr.status, type: fr.type, start: fr.start, end: fr.end, intervalCount: fr.intervalCount, intervalUnit: fr.intervalUnit, value: fr.value, compensation: fr.compensation)
            );
          },
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
