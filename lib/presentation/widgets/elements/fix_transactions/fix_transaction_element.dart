import 'package:flutter/material.dart';
import 'package:organizer/app/defaults.dart';
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
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fixTransactions.isEmpty
          ? const Center(child: Text('There are no fix transactions'))
          : LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final isMobile = width <= Defaults.maxMobileWidth;

                final activeTransactions = _fixTransactions
                    .where((f) => f.status == Status.active)
                    .toList();

                final inactiveTransactions = _fixTransactions
                    .where((f) => f.status == Status.inactive)
                    .toList();

                if (isMobile) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'Fix Transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      _buildActiveCards(activeTransactions),
                      const SizedBox(height: 16),
                      _buildInactiveTable(
                        inactiveTransactions,
                        maxWidth: double.infinity,
                      ),
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                'Fix Transactions',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            _buildActiveCards(activeTransactions),
                          ],
                        ),
                      ),

                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 300),
                        child: Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                          ),
                          padding: const EdgeInsets.only(left: 6),
                          child: _buildInactiveTable(inactiveTransactions),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
    );
  }

  Widget _buildActiveCards(List<FixTransaction> active) {
    if (active.isEmpty) return const Center(child: Text('There are no active fix transactions'));

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxCardWidth = 240;
        final double spacing = 4;
        final double availableWidth = constraints.maxWidth;

        int cardsPerRow = (availableWidth / (maxCardWidth + spacing))
            .floor()
            .clamp(1, active.length);

        final double cardWidth =
            (availableWidth - (spacing * (cardsPerRow - 1))) / cardsPerRow;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: active.map((f) {
            return SizedBox(
              width: cardWidth,
              child: FixTransactionActiveCard(
                fixTransaction: f,
                edit: (id) => updateFixTransaction(id),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildInactiveTable(
    List<FixTransaction> inactive, {
    double? maxWidth,
  }) {
    return SizedBox(
      width: maxWidth ?? double.infinity,
      child: FixTransactionInactiveTable(
        fixTransactions: inactive,
        edit: (id) => updateFixTransaction(id),
      ),
    );
  }
}
