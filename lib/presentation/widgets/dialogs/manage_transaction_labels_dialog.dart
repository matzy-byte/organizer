import 'package:flutter/material.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_transaction_label_dialog.dart';
import 'package:provider/provider.dart';

class ManageTransactionLabelsDialog extends StatelessWidget {
  const ManageTransactionLabelsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final transactionLabelProvider = context.watch<TransactionLabelProvider>();
    final fixTransactionProvider = context.read<FixTransactionProvider>();
    final varTransactionProvider = context.read<VarTransactionProvider>();

    final labels = transactionLabelProvider.transactionLabels;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                '${at.manage} ${at.transaction} ${at.labels}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),

              // Add Label Button
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: Text('${at.add} ${at.label}'),
                  onPressed: () async {
                    await showDialog<bool>(
                      context: context,
                      builder: (_) => const AddTransactionLabelDialog(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // List of labels
              Expanded(
                child: labels.isEmpty
                    ? Center(child: Text(at.noItem(at.labels)))
                    : ListView.separated(
                        itemCount: labels.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final label = labels[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              title: Text(label.name),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Edit button
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () async {
                                      await showDialog<bool>(
                                        context: context,
                                        builder: (_) =>
                                            AddTransactionLabelDialog(
                                              transactionLabel: label,
                                            ),
                                      );
                                    },
                                  ),
                                  // Delete button
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await transactionLabelProvider
                                          .removeTransactionLabel(label.id);
                                      await fixTransactionProvider.reload();
                                      await varTransactionProvider.reload();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 16),

              // Close button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(at.close),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
