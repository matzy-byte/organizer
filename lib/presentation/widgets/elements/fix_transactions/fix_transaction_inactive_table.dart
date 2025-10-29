import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/main.dart';

class FixTransactionInactiveTable extends StatelessWidget {
  final List<FixTransaction> fixTransactions;
  final IntCallback edit;
  const FixTransactionInactiveTable({
    super.key,
    required this.fixTransactions,
    required this.edit,
  });

  @override
  Widget build(BuildContext context) {
    return fixTransactions.isEmpty
        ? const Center(child: Text('No inactive fix transactions'))
        : ListView.separated(
            shrinkWrap: true,
            itemCount: fixTransactions.length,
            separatorBuilder: (_, _) => const Divider(
              height: 1,
              color: Color.fromARGB(255, 214, 214, 214),
              indent: 5.0,
              endIndent: 5.0,
            ),
            itemBuilder: (context, index) {
              final t = fixTransactions[index];
              final finalValue = getFinalValue(t);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 6.0,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.pause_circle_filled,
                      color: Colors.grey,
                      size: 20,
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      flex: 2,
                      child: Text(
                        NumberFormat.currency(
                          symbol: "€",
                        ).format(finalValue / 100),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 4,
                      child: Text(
                        t.description ?? '-',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),

                    IconButton(
                      onPressed: () => edit.call(t.id),
                      icon: const Icon(Icons.edit, color: Colors.blueGrey),
                      tooltip: 'Edit transaction',
                    ),
                  ],
                ),
              );
            },
          );
  }

  int getFinalValue(FixTransaction fixTransaction) {
    final compensations = fixTransaction.compensations;
    if (compensations == null) {
      return fixTransaction.value;
    }
    final compensationSum = compensations.values.fold<int>(
      0,
      (sum, c) => sum + c.value,
    );
    return fixTransaction.value - compensationSum;
  }
}
