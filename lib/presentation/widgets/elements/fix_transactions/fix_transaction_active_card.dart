import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/main.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:provider/provider.dart';

class FixTransactionActiveCard extends StatelessWidget {
  final FixTransaction fixTransaction;
  final IntCallback edit;

  const FixTransactionActiveCard({
    super.key,
    required this.fixTransaction,
    required this.edit,
  });

  int? _daysUntilNext() {
    final now = DateTime.now();
    DateTime next = fixTransaction.start;

    while (next.isBefore(now) && next.isBefore(fixTransaction.end)) {
      switch (fixTransaction.intervalUnit) {
        case IntervalUnit.day:
          next = next.add(Duration(days: fixTransaction.intervalCount));
          break;
        case IntervalUnit.week:
          next = next.add(Duration(days: 7 * fixTransaction.intervalCount));
          break;
        case IntervalUnit.month:
          next = DateTime(
            next.year,
            next.month + fixTransaction.intervalCount,
            next.day,
          );
          break;
        case IntervalUnit.year:
          next = DateTime(
            next.year + fixTransaction.intervalCount,
            next.month,
            next.day,
          );
          break;
        case IntervalUnit.decade:
          next = DateTime(
            next.year + 10 * fixTransaction.intervalCount,
            next.month,
            next.day,
          );
          break;
      }
    }

    if (next.isBefore(now)) return null;
    return next.difference(now).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final daysLeft = _daysUntilNext();
    TransactionLabel? label = null;
    if (fixTransaction.transactionLabelId != null) {
      label = context
          .read<TransactionLabelProvider>()
          .transactionLabels
          .firstWhere((t) => t.id == fixTransaction.transactionLabelId);
    }

    final valueColor = fixTransaction.value >= 0
        ? Colors.green
        : theme.colorScheme.error;

    final formattedValue = NumberFormat.currency(
      symbol: "€",
    ).format(fixTransaction.value / 100);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formattedValue,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: valueColor,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 6),
            if (label != null) ...[
              Chip(
                label: Text(
                  label.name,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 6),
            ],
            if (fixTransaction.description != null) ...[
              Text(
                fixTransaction.description!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
            ],
            Text(
              daysLeft == null
                  ? "No upcoming payment"
                  : "Next in $daysLeft day${daysLeft == 1 ? '' : 's'}",
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),

            const SizedBox(height: 8),
            Text(
              "${fixTransaction.intervalCount} ${fixTransaction.intervalUnit.name}"
              "${fixTransaction.intervalCount > 1 ? 's' : ''}",
              style: theme.textTheme.bodySmall,
            ),

            const SizedBox(height: 12),
            IconButton(
              icon: Icon(Icons.edit, color: theme.colorScheme.secondary),
              onPressed: () => edit(fixTransaction.id),
              tooltip: "Edit transaction",
            ),
          ],
        ),
      ),
    );
  }
}
