import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:organizer/core/models/var_transaction.dart';

class OverviewPie extends StatelessWidget {
  final List<VarTransaction> varTransactions;
  const OverviewPie({super.key, required this.varTransactions});

  @override
  Widget build(BuildContext context) {
    final sum = varTransactions.fold(0, (sum, c) => sum + c.value.abs());
    final List<PieChartSectionData> sections = varTransactions.map((t) {
      final value = t.compensations == null
          ? t.value
          : t.value -
                t.compensations!.values.fold(
                  0,
                  (compSum, c) => compSum + c.value,
                );
      return PieChartSectionData(
        color: value >= 0 ? Colors.green : Colors.red,
        value: value / sum,
        title: t.description,
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: PieChart(
        PieChartData(
          sections: sections,
          centerSpaceRadius: 40,
          sectionsSpace: 2,
          pieTouchData: PieTouchData(enabled: false),
        ),
      ),
    );
  }
}
