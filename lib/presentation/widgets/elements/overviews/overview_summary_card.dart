import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewSummaryCard extends StatelessWidget {
  final int totalValue;
  final int totalCompensations;

  const OverviewSummaryCard({
    super.key,
    required this.totalValue,
    required this.totalCompensations,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final netTotal = totalValue - totalCompensations;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _SummaryRow(label: 'Total Transaction Value', value: totalValue),
            _SummaryRow(
              label: 'Total Compensations',
              value: -totalCompensations,
            ),
            const SizedBox(height: 100),
            const Divider(height: 20),
            _SummaryRow(label: 'Net Total', value: netTotal, isBold: true),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final int value;
  final bool isBold;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = value >= 0 ? Colors.green[700] : Colors.red[700];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            NumberFormat.currency(symbol: '€').format(value / 100),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
