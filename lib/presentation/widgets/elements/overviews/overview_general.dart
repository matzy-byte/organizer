import 'package:flutter/material.dart';
import 'package:organizer/app/defaults.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_pie.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_summary_card.dart';
import 'package:provider/provider.dart';

class OverviewGeneral extends StatelessWidget {
  final List<VarTransaction> varTransactions;
  const OverviewGeneral({super.key, required this.varTransactions});

  @override
  Widget build(BuildContext context) {
    final transactionLabelProvider = context.read<TransactionLabelProvider>();
    final totalValue = varTransactions.fold<int>(0, (sum, t) => sum + t.value);
    final totalCompensations = varTransactions.fold<int>(0, (sum, t) {
      if (t.compensations == null) return sum;
      return sum +
          t.compensations!.values.fold<int>(
            0,
            (compSum, c) => compSum + c.value,
          );
    });

    final transactionLabelCounts = <String, int>{};
    for (var t in varTransactions) {
      if (t.transactionLabelId == null) {
        continue;
      }
      final label = transactionLabelProvider.transactionLabels.firstWhere((l) => l.id == t.transactionLabelId).name;
      transactionLabelCounts[label] =
          (transactionLabelCounts[label] ?? 0) + 1;
    }

    final compensationTopics = <String, int>{};
    for (var t in varTransactions) {
      if (t.compensations != null) {
        for (var c in t.compensations!.values) {
          compensationTopics[c.topicName] =
              (compensationTopics[c.topicName] ?? 0) + 1;
        }
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
                SizedBox(
                  width: cardWidth,
                  child: OverviewPie(
                    title: 'Transaction Description',
                    data: transactionLabelCounts,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: OverviewPie(
                    title: 'Compensation Topics',
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
