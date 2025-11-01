import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_transaction_label_dialog.dart';
import 'package:provider/provider.dart';

class ManageTransactionLabelsDialog extends StatelessWidget {
  const ManageTransactionLabelsDialog({super.key});
  @override
  Widget build(BuildContext context) {
    final transactionLabelProvider = context.read<TransactionLabelProvider>();

    return AlertDialog(
      title: const Text('Manage Transaction Labels'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(onPressed: () async {
            await showDialog(context: context, builder: (_) => AddTransactionLabelDialog());
          }, icon: Icon(Icons.add)),
          ...transactionLabelProvider.transactionLabels.map(
            (l) => Row(
              children: [
                Text(l.name),
                IconButton(
                  onPressed: () async {
                    await transactionLabelProvider.removeTransactionLabel(l.id);
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (_) =>
                          AddTransactionLabelDialog(transactionLabel: l),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
