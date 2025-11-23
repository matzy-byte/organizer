import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:organizer/app/defaults.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_pie.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_summary_card.dart';
import 'package:provider/provider.dart';

class OverviewGeneral extends StatelessWidget {
  final List<VarTransaction> varTransactions;
  final isDashboard;
  const OverviewGeneral({
    super.key,
    required this.varTransactions,
    this.isDashboard = false,
  });

  @override
  Widget build(BuildContext context) {
    final filteredTransactions = isDashboard
        ? varTransactions.where((t) => t.varRefId == null).toList()
        : varTransactions;

    final transactionLabelProvider = context.read<TransactionLabelProvider>();
    final totalValue = filteredTransactions.fold<int>(
      0,
      (sum, t) => sum + t.value,
    );
    final totalCompensations = filteredTransactions.fold<int>(0, (sum, t) {
      if (t.compensations == null) return sum;
      return sum +
          t.compensations!.values.fold<int>(
            0,
            (compSum, c) => compSum + c.value,
          );
    });

    Map<int, (String, int)> transactions = {};
    for (var t in filteredTransactions) {
      if (t.transactionLabelId == null) continue;
      final labelObj = transactionLabelProvider.transactionLabels
          .firstWhereOrNull((l) => l.id == t.transactionLabelId);
      if (labelObj == null) continue;
      final id = labelObj.id;
      final name = labelObj.name;
      final currentValue = transactions[id]?.$2 ?? 0;
      final newValue = currentValue + (t.value < 0 ? t.value : 0);
      transactions[id] = (name, newValue);
    }

    Map<int, (String, int)> compensationTopics = {};
    for (var t in filteredTransactions) {
      if (t.compensations == null) continue;
      for (var c in t.compensations!.values) {
        final id = c.topicId;
        final name = c.topicName;
        final currentValue = compensationTopics[id]?.$2 ?? 0;
        final newValue = currentValue + (c.value < 0 ? c.value : 0);
        compensationTopics[id] = (name, newValue);
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final cardWidth = width > Defaults.maxTabletWidth
            ? (width / 3) - 8
            : width > Defaults.maxMobileWidth
            ? (width / 2) - 8
            : width;

        return SingleChildScrollView(
          child: Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: OverviewSummaryCard(
                    totalValue: totalValue,
                    totalCompensations: totalCompensations,
                  ),
                ),
                if (transactions.isNotEmpty)
                  SizedBox(
                    width: cardWidth,
                    child: OverviewPie(title: 'Expenses', data: transactions),
                  ),
                if (compensationTopics.isNotEmpty)
                  SizedBox(
                    width: cardWidth,
                    child: OverviewPie(
                      title: 'Compensations',
                      data: compensationTopics,
                      colorPalette: [
                        Colors.green,
                        Colors.teal,
                        Colors.lightGreen,
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
