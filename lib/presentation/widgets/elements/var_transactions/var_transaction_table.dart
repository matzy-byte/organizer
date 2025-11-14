import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/main.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/show_compensations_dialog.dart';
import 'package:provider/provider.dart';

class VarTransactionTable extends StatelessWidget {
  final List<VarTransaction> varTransactions;
  final IntCallback delete;
  final IntCallback edit;

  const VarTransactionTable({
    super.key,
    required this.varTransactions,
    required this.delete,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    if (varTransactions.isEmpty) {
      return const Center(child: Text('No variable transactions'));
    }

    final transactionLabelProvider = context.watch<TransactionLabelProvider>();

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: varTransactions.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey.shade300, height: 1),
      itemBuilder: (context, index) {
        final t = varTransactions[index];
        final value = getFinalValue(t);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  NumberFormat.currency(symbol: "€").format(value / 100),
                  style: TextStyle(
                    color: value > 0
                        ? const Color(0xFF006400)
                        : const Color(0xFF8B0000),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              if (t.compensations != null)
                SizedBox(
                  width: 120,
                  child: Row(
                    children: [
                      Text(
                        '(${NumberFormat.currency(symbol: "€").format(t.compensations!.values.fold<int>(0, (sum, c) => sum + c.value) / 100)})',
                        style: TextStyle(
                          color: t.value > 0
                              ? const Color(0xFF006400)
                              : const Color(0xFF8B0000),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (context) =>
                                ShowCompensationsDialog(varTransaction: t),
                          );
                        },
                        icon: Icon(Icons.info, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),

              if (t.transactionLabelId != null)
                Chip(
                  label: Text(
                    transactionLabelProvider.transactionLabels
                            .where((l) => l.id == t.transactionLabelId)
                            .firstOrNull
                            ?.name ??
                        'Loading ...',
                  ),
                ),

              Expanded(
                flex: 2,
                child: Text(
                  t.description ?? '-',
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(
                width: 100,
                child: Text(DateFormat.yMd().format(t.date)),
              ),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20),
                    onPressed: () => delete.call(t.id),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20),
                    onPressed: () => edit.call(t.id),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  int getFinalValue(VarTransaction varTransaction) {
    final compensations = varTransaction.compensations;
    if (compensations == null) {
      return varTransaction.value;
    }
    final compensationSum = compensations.values.fold<int>(
      0,
      (sum, c) => sum + c.value,
    );
    return varTransaction.value - compensationSum;
  }
}
