import 'package:flutter/material.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/edit_fix_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/elements/fix_transactions/fix_transaction_active_card.dart';
import 'package:organizer/presentation/widgets/elements/fix_transactions/fix_transaction_inactive_table.dart';
import 'package:provider/provider.dart';

class FixTransactionElement extends StatefulWidget {
  const FixTransactionElement({super.key});

  @override
  State<FixTransactionElement> createState() => FixTransactionElementState();
}

class FixTransactionElementState extends State<FixTransactionElement> {
  Topic? _topic;
  List<FixTransaction> _fixTransactions = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final topic = ModalRoute.of(context)!.settings.arguments as Topic;
    if (_topic != topic) {
      _topic = topic;
      loadFixTransactions();
    }
  }

  Future<void> loadFixTransactions() async {
    if (_topic == null) return;
    if (!mounted) return;
    setState(() => _isLoading = true);
    final fixTransactionProvider = context.read<FixTransactionProvider>();
    final fixTransactions = await fixTransactionProvider
        .getAllFixTransactionsByTopicId(_topic!.id);
    if (!mounted) return;
    setState(() {
      _fixTransactions = fixTransactions;
      _isLoading = false;
    });
  }

  Future<void> updateFixTransaction(int id) async {
    final updated = await showDialog<bool>(
      context: context,
      builder: (context) => EditFixTransactionDialog(
        fixTransaction: _fixTransactions.firstWhere((v) => v.id == id),
      ),
    );
    if (!mounted) return;
    if (updated == true) {
      loadFixTransactions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Fix Transactions'),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _fixTransactions.isEmpty
              ? const Center(child: Text('There are no fix transactions'))
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: _fixTransactions
                            .where((f) => f.status == Status.active)
                            .map(
                              (f) => SizedBox(
                                width: 250,
                                child: FixTransactionActiveCard(
                                  fixTransaction: f,
                                  edit: (id) => updateFixTransaction(id),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(left: 16),
                        child: FixTransactionInactiveTable(
                          fixTransactions: _fixTransactions
                              .where((f) => f.status == Status.inactive)
                              .toList(),
                          edit: (id) => updateFixTransaction(id),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
