import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/edit_var_transaction_dialog.dart';
import 'package:provider/provider.dart';

class ShowCompensationsDialog extends StatefulWidget {
  final VarTransaction varTransation;
  const ShowCompensationsDialog({super.key, required this.varTransation});

  @override
  State<StatefulWidget> createState() => _ShowCompensationsDialogState();
}

class _ShowCompensationsDialogState extends State<ShowCompensationsDialog> {
  List<VarTransaction> _varTransactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    loadVarTransactions();
  }

  Future<void> loadVarTransactions() async {
    if (widget.varTransation.compensations!.isEmpty) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      return;
    }
    ;
    if (!mounted) return;
    setState(() => _isLoading = true);
    final varTransactionProvider = context.read<VarTransactionProvider>();
    final List<VarTransaction> varTransactions = [];
    for (final id in widget.varTransation.compensations!.keys) {
      varTransactions.add(await varTransactionProvider.get(id));
    }
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
    widget.varTransation.compensations?.remove(id);
    _varTransactions.removeWhere((v) => v.id == id);
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
    return AlertDialog(
      title: Text('Compensations'),
      content: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _varTransactions.isEmpty
          ? const Center(
              heightFactor: double.minPositive,
              child: Text('No compensations set'),
            )
          : SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _varTransactions.map((t) {
                    final value = getFinalValue(t);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 80,
                            child: Text(
                              NumberFormat.currency(
                                symbol: "€",
                              ).format(value / 100),
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
                                            ShowCompensationsDialog(
                                              varTransation: t,
                                            ),
                                      );
                                    },
                                    icon: Icon(
                                      Icons.info,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          Expanded(
                            flex: 2,
                            child: Text(
                              'Topic: ${widget.varTransation.compensations![t.id]!.topicName}',
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
                                onPressed: () async =>
                                    await removeVarTransaction(t.id),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, size: 20),
                                onPressed: () async =>
                                    await updateVarTransaction(t.id),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
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
