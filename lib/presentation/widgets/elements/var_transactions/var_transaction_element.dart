import 'package:flutter/material.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/edit_var_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/elements/var_transactions/var_transaction_table.dart';
import 'package:provider/provider.dart';

class VarTransactionElement extends StatefulWidget {
  const VarTransactionElement({super.key});

  @override
  State<VarTransactionElement> createState() => VarTransactionElementState();
}

class VarTransactionElementState extends State<VarTransactionElement> {
  Topic? _topic;
  List<VarTransaction> _varTransactions = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    if (_topic != topic) {
      _topic = topic;
      loadVarTransactions();
    }
  }

  Future<void> loadVarTransactions() async {
    if (_topic == null) return;
    if (!mounted) return;
    setState(() => _isLoading = true);
    final varTransactionProvider = context.read<VarTransactionProvider>();
    final varTransactions = await varTransactionProvider
        .getAllVarTransactionsByTopicId(_topic!.id);
    if (!mounted) return;
    setState(() {
      _varTransactions = varTransactions;
      _isLoading = false;
    });
  }

  Future<void> removeVarTransaction(int id) async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    final varTransactionProvider = context.read<VarTransactionProvider>();
    await varTransactionProvider.removeVarTransaction(id);
    _varTransactions.removeWhere((v) => v.id == id);
    if (!mounted) return;
    loadVarTransactions();
  }

  Future<void> updateVarTransaction(int id) async {
    final updated = await showDialog<bool>(
      context: context,
      builder: (context) => EditVarTransactionDialog(
        varTransaction: _varTransactions.firstWhere((v) => v.id == id),
      ),
    );
    if (!mounted) return;
    if (updated == true) {
      loadVarTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Var Transactions'),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _varTransactions.isEmpty
              ? Text('There is no var transactions')
              : VarTransactionTable(
                  varTransactions: _varTransactions,
                  delete: (id) => removeVarTransaction(id),
                  edit: (id) => updateVarTransaction(id),
                ),
        ],
      ),
    );
  }
}
