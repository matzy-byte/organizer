import 'package:flutter/material.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/elements/overviews/overview_general.dart';
import 'package:provider/provider.dart';

class OverviewElement extends StatefulWidget {
  final int topicId;
  const OverviewElement({super.key, required this.topicId});

  @override
  State<OverviewElement> createState() => OverviewElementState();
}

class OverviewElementState extends State<OverviewElement> {
  List<VarTransaction> _varTransactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    loadAllVarTransactions();
  }

  Future<void> loadAllVarTransactions() async {
    setState(() => _isLoading = true);
    final varTransactionProvider = context.read<VarTransactionProvider>();
    final varTransactions = await varTransactionProvider
        .getAllVarTransactionsByTopicId(widget.topicId);
    setState(() {
      _varTransactions = varTransactions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Overview'),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    OverviewGeneral(varTransactions: _varTransactions),
                  ],
                ),
        ],
      ),
    );
  }
}
