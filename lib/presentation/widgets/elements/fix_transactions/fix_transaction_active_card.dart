import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/main.dart';

class FixTransactionActiveCard extends StatelessWidget {
  final FixTransaction fixTransaction;
  final IntCallback edit;
  const FixTransactionActiveCard({
    super.key,
    required this.fixTransaction,
    required this.edit,
  });

  int? getDaysUntilNextPayment() {
    final now = DateTime.now();
    DateTime nextDate = fixTransaction.start;

    while (nextDate.isBefore(now) && nextDate.isBefore(fixTransaction.end)) {
      switch (fixTransaction.intervalUnit) {
        case IntervalUnit.day:
          nextDate = nextDate.add(Duration(days: fixTransaction.intervalCount));
          break;
        case IntervalUnit.week:
          nextDate = nextDate.add(
            Duration(days: 7 * fixTransaction.intervalCount),
          );
          break;
        case IntervalUnit.month:
          nextDate = DateTime(
            nextDate.year,
            nextDate.month + fixTransaction.intervalCount,
            nextDate.day,
          );
          break;
        case IntervalUnit.year:
          nextDate = DateTime(
            nextDate.year + fixTransaction.intervalCount,
            nextDate.month,
            nextDate.day,
          );
          break;
        case IntervalUnit.decade:
          nextDate = DateTime(
            nextDate.year + (10 * fixTransaction.intervalCount),
            nextDate.month,
            nextDate.day,
          );
          break;
      }
    }

    if (nextDate.isBefore(now)) return null;
    return nextDate.difference(now).inDays;
  }

  @override
  Widget build(BuildContext context) {
    final int? daysLeft = getDaysUntilNextPayment();
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              NumberFormat.currency(
                symbol: "€",
              ).format(fixTransaction.value / 100),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: fixTransaction.value > 0
                    ? const Color(0xFF006400)
                    : const Color(0xFF8B0000),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            Text(
              fixTransaction.description ?? '-',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 6),

            Text(
              daysLeft == null
                  ? "No upcoming payment"
                  : "Next in $daysLeft day${daysLeft == 1 ? '' : 's'}",
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),

            const SizedBox(height: 8),

            Text(
              "${fixTransaction.intervalCount} ${fixTransaction.intervalUnit.name}${fixTransaction.intervalCount > 1 ? 's' : ''}",
              style: const TextStyle(fontSize: 13),
            ),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.blueGrey),
                onPressed: () => edit.call(fixTransaction.id),
                tooltip: "Edit transaction",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
