import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/app/defaults.dart';
import 'package:organizer/core/models/var_transaction.dart';

class OverviewGeneral extends StatelessWidget {
  final List<VarTransaction> varTransactions;
  const OverviewGeneral({super.key, required this.varTransactions});

  @override
  Widget build(BuildContext context) {
    final totalValue = varTransactions.fold(0, (sum, t) => sum + t.value);
    final totalCompensations = varTransactions.fold(
      0,
      (sum, t) => (t.compensations == null)
          ? sum
          : sum +
              t.compensations!.values.fold(
                0,
                (compSum, c) => compSum + c.value,
              ),
    );

    final Map<String, int> descriptionCounts = {};
    for (var t in varTransactions) {
      descriptionCounts[t.description ?? '-'] =
          (descriptionCounts[t.description ?? '-'] ?? 0) + 1;
    }

    final Map<String, int> compensationTopics = {};
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

        double cardWidth;
        if (width > Defaults.maxTabletWidth) {
          cardWidth = (width / 3) - 4;
        } else if (width > Defaults.maxMobileWidth) {
          cardWidth = (width / 2) - 4;
        } else {
          cardWidth = width - 4;
        }

        return SingleChildScrollView(
          child: Center(
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildOverviewCard(totalValue, totalCompensations,
                      isSmall: width < 800),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildChartCard(
                    title: 'Transaction Description',
                    data: descriptionCounts,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  child: _buildChartCard(
                    title: 'Compensation Topics',
                    data: compensationTopics,
                    colorPalette: [Colors.green, Colors.teal, Colors.lightGreen],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverviewCard(int totalValue, int totalCompensations,
      {bool isSmall = false}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: isSmall ? 150 : 268, // 👈 Taller on mobile
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Overview',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              _buildSummaryRow('Total Transaction Value', totalValue),
              _buildSummaryRow('Total Compensations', -totalCompensations),
              const Divider(height: 20),
              _buildSummaryRow(
                'Net Total',
                totalValue - totalCompensations,
                isBold: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, int value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          Text(
            NumberFormat.currency(symbol: "€").format(value / 100),
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required Map<String, int> data,
    List<Color>? colorPalette,
  }) {
    final total = data.values.fold<int>(0, (sum, v) => sum + v);
    final colors =
        colorPalette ?? [Colors.blue, Colors.orange, Colors.purple, Colors.cyan];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: data.entries.mapIndexed((i, e) {
                    final percentage =
                        total == 0 ? 0 : (e.value / total * 100).toStringAsFixed(1);
                    return PieChartSectionData(
                      color: colors[i % colors.length],
                      value: e.value.toDouble(),
                      title: '$percentage%',
                      radius: 60,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 4,
              children: data.entries.mapIndexed((i, e) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: colors[i % colors.length],
                    ),
                    const SizedBox(width: 4),
                    Text('${e.key} (${e.value})'),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Map Indexed Helper ---
extension MapIndexed<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}
