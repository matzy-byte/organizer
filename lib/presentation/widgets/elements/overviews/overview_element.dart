import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_general.dart';
import 'package:provider/provider.dart';

class OverviewElement extends StatelessWidget {
  const OverviewElement({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<VarTransactionProvider>().varTransactions;
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
              'Overview',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            OverviewGeneral(varTransactions: items),
          ],
        ),
      ),
    );
  }
}
