import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/user.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/l10n/app_localizations.dart';

class OverviewUserSummaryCard extends StatelessWidget {
  final Map<User, List<VarTransaction>> userTransactions;
  const OverviewUserSummaryCard({super.key, required this.userTransactions});

  List<_UserSettlement> _calculateSettlements(
    Map<User, List<VarTransaction>> userTransactions,
  ) {
    final net = <User, int>{};
    for (var entry in userTransactions.entries) {
      final income = entry.value
          .where((t) => t.value >= 0)
          .fold(0, (s, t) => s + t.value);
      final expense = entry.value
          .where((t) => t.value < 0)
          .fold(0, (s, t) => s + t.value);
      net[entry.key] = income + expense;
    }

    final total = net.values.fold(0, (s, n) => s + n);
    final users = net.length;
    final fairShare = total ~/ users;

    final positive = <MapEntry<User, int>>[];
    final negative = <MapEntry<User, int>>[];

    net.forEach((user, value) {
      final diff = value - fairShare;
      if (diff > 0) {
        positive.add(MapEntry(user, diff));
      } else if (diff < 0) {
        negative.add(MapEntry(user, -diff));
      }
    });

    final settlements = <_UserSettlement>[];

    int iPos = 0;
    int iNeg = 0;

    while (iPos < positive.length && iNeg < negative.length) {
      final creditor = positive[iPos];
      final debtor = negative[iNeg];

      final amount = creditor.value < debtor.value
          ? creditor.value
          : debtor.value;

      settlements.add(_UserSettlement(debtor.key, creditor.key, amount));

      positive[iPos] = MapEntry(creditor.key, creditor.value - amount);
      negative[iNeg] = MapEntry(debtor.key, debtor.value - amount);

      if (positive[iPos].value == 0) iPos++;
      if (negative[iNeg].value == 0) iNeg++;
    }

    return settlements;
  }

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final settlements = _calculateSettlements(userTransactions);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${at.user} ${at.summary}',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...userTransactions.entries.map(
              (e) => _SummaryRow(
                label: e.key.name,
                valueIncome: e.value
                    .where((i) => i.value >= 0)
                    .fold<int>(0, (sum, t) => sum + t.value),
                valueExpenses: e.value
                    .where((i) => i.value < 0)
                    .fold<int>(0, (sum, t) => sum + t.value),
              ),
            ),
            ...[
              const SizedBox(height: 20),
              Text(
                'Split',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              ...settlements.map(
                (s) => Text(
                  '${s.from.name} → ${s.to.name}: ${NumberFormat.currency(symbol: "€").format(s.amount / 100)}',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final int valueIncome;
  final int valueExpenses;
  final bool isBold = false;

  const _SummaryRow({
    required this.label,
    required this.valueIncome,
    required this.valueExpenses,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final netTotal = (valueIncome + valueExpenses) / 100;
    final netColor = netTotal >= 0 ? Colors.green[700] : Colors.red[700];

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
            NumberFormat.currency(symbol: '€').format(valueIncome / 100),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.green[700],
            ),
          ),
          Text(
            NumberFormat.currency(symbol: '€').format(valueExpenses / 100),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.red[700],
            ),
          ),
          Text(
            NumberFormat.currency(symbol: '€').format(netTotal),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: netColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserSettlement {
  final User from;
  final User to;
  final int amount;

  const _UserSettlement(this.from, this.to, this.amount);
}
