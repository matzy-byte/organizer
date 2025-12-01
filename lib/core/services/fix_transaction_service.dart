import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/repositories/fix_transactions_repository.dart';
import 'package:organizer/core/repositories/var_transactions_repository.dart';
import 'package:organizer/core/utils/date_util.dart';

class FixTransactionService {
  final FixTransactionRepository repository;
  final VarTransactionRepository varTransactionRepository;

  FixTransactionService(this.repository, this.varTransactionRepository);

  Future<List<FixTransaction>> getAllFixTransactionsByTopicId(
    int topicId,
  ) async {
    final transactions = await repository.getAllFixTransactionsByTopicId(
      topicId,
    );
    return transactions;
  }

  Future<int> addFixTransaction(
    int topicId,
    Status status,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    int userRefId,
    DateTime lastEdit,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
    int? fileRefId,
  ) => repository.addFixTransaction(
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    userRefId,
    lastEdit,
    compensations,
    transactionLabelId,
    description,
    latestDate,
    varRefId,
    fileRefId,
  );
  Future<void> deleteFixTransaction(int id) =>
      repository.deleteFixTransaction(id);
  Future<void> updateFixTransaction(
    int id,
    int topicId,
    Status status,
    DateTime start,
    DateTime end,
    int intervalCount,
    IntervalUnit intervalUnit,
    int value,
    int userRefId,
    DateTime lastEdit,
    Map<int, CompensationInfo>? compensations,
    int? transactionLabelId,
    String? description,
    DateTime? latestDate,
    int? varRefId,
    int? fileRefId,
  ) => repository.updateFixTransaction(
    id,
    topicId,
    status,
    start,
    end,
    intervalCount,
    intervalUnit,
    value,
    userRefId,
    lastEdit,
    compensations,
    transactionLabelId,
    description,
    latestDate,
    varRefId,
    fileRefId,
  );

  Future<void> runDueFixTransactions() async {
    final fixes = await repository.getAllFixTransactions();

    for (final fix in fixes.where((f) => f.status == Status.active)) {
      await _processFixTransaction(fix);
    }
  }

  Future<void> _processFixTransaction(FixTransaction fix) async {
    DateTime last = fix.latestDate ?? fix.start;
    final DateTime today = DateTime.now();

    while (true) {
      final nextDate = DateUtil.addInterval(
        last,
        fix.intervalCount,
        fix.intervalUnit,
      );

      final isDue =
          nextDate.isBefore(today) || DateUtil.sameDay(nextDate, today);
      final withinEnd =
          nextDate.isBefore(fix.end) || DateUtil.sameDay(nextDate, fix.end);

      if (fix.latestDate == null &&
          DateUtil.sameDay(fix.start, today) &&
          last == fix.start) {
        await _createVarTransaction(fix, today);
        last = today;
        continue;
      }

      if (!isDue || !withinEnd) {
        break;
      }

      await _createVarTransaction(fix, nextDate);

      last = nextDate;
    }
  }

  Future<void> _createVarTransaction(FixTransaction fix, DateTime date) async {
    final varRefId = await varTransactionRepository.addVarTransaction(
      fix.topicId,
      date,
      fix.value,
      fix.userRefId,
      DateTime.now(),
      fix.compensations,
      fix.transactionLabelId,
      fix.description,
      fix.id,
      null,
      fix.fileRefId,
    );

    await repository.updateFixTransaction(
      fix.id,
      fix.topicId,
      fix.status,
      fix.start,
      fix.end,
      fix.intervalCount,
      fix.intervalUnit,
      fix.value,
      fix.userRefId,
      DateTime.now(),
      fix.compensations,
      fix.transactionLabelId,
      fix.description,
      date,
      varRefId,
      fix.fileRefId,
    );
  }
}
