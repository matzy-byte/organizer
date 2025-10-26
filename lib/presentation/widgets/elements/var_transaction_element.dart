import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/edit_var_transaction_dialog.dart';
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
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _varTransactions.isEmpty
          ? Text('There is no var transactions')
          : VarTransactionTable(
              varTransactions: _varTransactions,
              delete: (id) => removeVarTransaction(id),
              edit: (id) => updateVarTransaction(id),
            ),
    );
  }
}

typedef IntCallback = void Function(int value);

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Table(
          border: TableBorder.all(color: Colors.grey.shade300),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
          },
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Color(0xFFEFEFEF)),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Value',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Description',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Delete',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Edit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ...varTransactions.map(
              (t) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getFinalValue(t).toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(t.description ?? '-'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(DateFormat.yMd().format(t.date)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => delete.call(t.id),
                      icon: Icon(Icons.delete),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () => edit.call(t.id),
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
