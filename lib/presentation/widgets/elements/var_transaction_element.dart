import 'package:flutter/material.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';

class VarTransactionElement extends StatefulWidget {
  const VarTransactionElement({super.key});

  @override
  State<VarTransactionElement> createState() => _VarTransactionElementState();
}

class _VarTransactionElementState extends State<VarTransactionElement> {
  Topic? _topic;
  List<VarTransaction> _varTransactions = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    if (_topic != topic) {
      _topic = topic;
      _loadVarTransactions();
    }
  }

  Future<void> _loadVarTransactions() async {
    if (_topic == null) return;
    setState(() => _isLoading = true);
    final varTransactionProvider = context.read<VarTransactionProvider>();
    final varTransactions = await varTransactionProvider
        .getAllVarTransactionsByTopic(_topic!);
    setState(() {
      _varTransactions = varTransactions;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _varTransactions.isEmpty
          ? Text('There is no var transactions')
          : Column(
              children: [
                ..._varTransactions.map(
                  (f) => VarTransactionSubElement(varTransaction: f),
                ),
              ],
            ),
    );
  }
}

class VarTransactionSubElement extends StatelessWidget {
  final VarTransaction varTransaction;
  const VarTransactionSubElement({super.key, required this.varTransaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(varTransaction.value.toString()),
    );
  }
}
