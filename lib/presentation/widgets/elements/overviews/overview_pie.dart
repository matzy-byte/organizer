import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OverviewPie extends StatelessWidget {
  final String title;
  final Map<int, (String, int)> data;
  final List<Color>? colorPalette;

  const OverviewPie({
    super.key,
    required this.title,
    required this.data,
    this.colorPalette,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final total = data.values.fold<int>(0, (sum, v) => sum + v.$2.abs());

    final colors =
        colorPalette ??
        [Colors.blue, Colors.orange, Colors.purple, Colors.cyan];

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 180,
              child: PieChart(
                PieChartData(
                  sections: data.entries.mapIndexed((i, e) {
                    final value = e.value.$2.abs();

                    final percentage = total == 0
                        ? "0.0"
                        : (value / total * 100).toStringAsFixed(1);

                    return PieChartSectionData(
                      color: colors[i % colors.length],
                      value: value.toDouble(),
                      title: '$percentage%',
                      radius: 60,
                      titleStyle: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList(),
                  centerSpaceRadius: 40,
                  sectionsSpace: 2,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: data.entries.mapIndexed((i, e) {
                final name = e.value.$1;
                final value = e.value.$2;

                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      color: colors[i % colors.length],
                    ),
                    const SizedBox(width: 4),
                    Text('$name ($value)', style: theme.textTheme.bodySmall),
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

extension MapIndexed<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E e) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}
