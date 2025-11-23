import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewSummaryCard extends StatelessWidget {
  final int totalValueIncome;
  final int totalValueExpenses;

  final int totalCompensationsIncome;
  final int totalCompensationsExpenses;

  const OverviewSummaryCard({
    super.key,
    required this.totalValueIncome,
    required this.totalValueExpenses,
    required this.totalCompensationsIncome,
    required this.totalCompensationsExpenses,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final netValue = totalValueIncome + totalValueExpenses;
    final netCompensations =
        totalCompensationsIncome + totalCompensationsExpenses;
    final netTotal = netValue - netCompensations;

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

            // ----- TRANSACTION VALUES -----
            _SummaryRow(label: 'Income', value: totalValueIncome),
            _SummaryRow(label: 'Expenses', value: totalValueExpenses),

            const SizedBox(height: 12),

            // ----- COMPENSATIONS -----
            _SummaryRow(
              label: 'Compensation Income',
              value: -totalCompensationsIncome,
            ),
            _SummaryRow(
              label: 'Compensation Expenses',
              value: -totalCompensationsExpenses,
            ),

            const SizedBox(height: 100),
            const Divider(height: 20),

            // ----- NET -----
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
