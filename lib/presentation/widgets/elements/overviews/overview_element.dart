import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_general.dart';
import 'package:provider/provider.dart';

class OverviewElement extends StatelessWidget {
  const OverviewElement({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<VarTransactionProvider>().varTransactions;

    return Card(
      child: Column(
        children: [
          const Text("Overview"),
          OverviewGeneral(varTransactions: items),
        ],
      ),
    );
  }
}
