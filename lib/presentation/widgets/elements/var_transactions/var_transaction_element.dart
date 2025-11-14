import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/edit_var_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/elements/var_transactions/var_transaction_table.dart';
import 'package:provider/provider.dart';

class VarTransactionElement extends StatelessWidget {
  const VarTransactionElement({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VarTransactionProvider>();
    final items = provider.varTransactions;
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Variable Transactions',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (items.isEmpty)
              Text(
                'No transactions',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else
              VarTransactionTable(
                varTransactions: items,
                edit: (id) async {
                  final v = items.firstWhereOrNull((v) => v.id == id);
                  if (v == null) return;

                  await showDialog(
                    context: context,
                    builder: (context) =>
                        EditVarTransactionDialog(varTransaction: v),
                  );
                },
                delete: (id) async => await provider.removeVarTransaction(id),
              ),
          ],
        ),
      ),
    );
  }
}
