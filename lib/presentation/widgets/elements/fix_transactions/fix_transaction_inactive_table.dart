import 'package:flutter/material.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/main.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/widgets/currency_text.dart';
import 'package:organizer/presentation/widgets/dialogs/alert_delete.dart';
import 'package:provider/provider.dart';

class FixTransactionInactiveTable extends StatelessWidget {
  final List<FixTransaction> fixTransactions;
  final IntCallback edit;
  final IntCallback delete;

  const FixTransactionInactiveTable({
    super.key,
    required this.fixTransactions,
    required this.edit,
    required this.delete,
  });

  int _finalValue(FixTransaction t) {
    if (t.compensations == null) return t.value;
    final sum = t.compensations!.values.fold<int>(0, (s, c) => s + c.value);
    return t.value - sum;
  }

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    if (fixTransactions.isEmpty) {
      return Center(
        child: Text(
          at.noItem('${at.repeated} ${at.transactions}'),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
      );
    }

    final labelProvider = context.read<TransactionLabelProvider>();
    final labelMap = {for (var l in labelProvider.transactionLabels) l.id: l};

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: fixTransactions.length,
      separatorBuilder: (_, _) => Divider(
        height: 1,
        thickness: 1,
        color: theme.colorScheme.outlineVariant,
        indent: 6,
        endIndent: 6,
      ),
      itemBuilder: (context, index) {
        final t = fixTransactions[index];
        final finalValue = _finalValue(t);

        final label = t.transactionLabelId != null
            ? labelMap[t.transactionLabelId]
            : null;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          child: Row(
            children: [
              Icon(
                Icons.pause_circle_filled,
                size: 20,
                color: theme.colorScheme.outline,
              ),

              const SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: CurrencyText(
                  value: finalValue / 100,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (label != null) ...[
                const SizedBox(width: 12),
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
              ],

              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  t.description ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              IconButton(
                onPressed: () async {
                  final confirm = await AlertDelete.show(
                    context,
                    type: '${at.repeated} ${at.transaction}',
                    value: '${at.repeated} ${at.transaction}',
                  );
                  if (confirm == true) {
                    delete(t.id);
                  }
                },
                icon: Icon(Icons.delete, color: theme.colorScheme.secondary),
                tooltip: '${at.delete} ${at.transaction}',
              ),

              IconButton(
                onPressed: () => edit(t.id),
                icon: Icon(Icons.edit, color: theme.colorScheme.secondary),
                tooltip: '${at.edit} ${at.transaction}',
              ),
            ],
          ),
        );
      },
    );
  }
}
