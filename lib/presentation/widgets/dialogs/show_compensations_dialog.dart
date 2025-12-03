import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/currency_text.dart';
import 'package:organizer/presentation/widgets/dialogs/alert_delete.dart';
import 'package:organizer/presentation/widgets/dialogs/edit_var_transaction_dialog.dart';
import 'package:provider/provider.dart';

class ShowCompensationsDialog extends StatefulWidget {
  final VarTransaction varTransaction;
  const ShowCompensationsDialog({super.key, required this.varTransaction});

  @override
  State<ShowCompensationsDialog> createState() =>
      _ShowCompensationsDialogState();
}

class _ShowCompensationsDialogState extends State<ShowCompensationsDialog> {
  List<VarTransaction> _varTransactions = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVarTransactions();
  }

  Future<void> _loadVarTransactions() async {
    print(widget.varTransaction);
    if (widget.varTransaction.compensations == null ||
        widget.varTransaction.compensations!.isEmpty) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      return;
    }

    if (!mounted) return;
    setState(() => _isLoading = true);

    final varTransactionProvider = context.read<VarTransactionProvider>();
    final List<VarTransaction> varTransactions = [];

    for (final id in widget.varTransaction.compensations!.keys) {
      varTransactions.add(await varTransactionProvider.get(id));
    }

    if (!mounted) return;
    setState(() {
      _varTransactions = varTransactions;
      _isLoading = false;
    });
  }

  Future<void> _removeVarTransaction(int id, BuildContext context) async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    final at = AppLocalizations.of(context)!;
    bool confirm = await AlertDelete.show(context, type: at.transaction, value: at.transaction);
    if (confirm == false) {
      _loadVarTransactions();
      return;
    }

    // ignore: use_build_context_synchronously
    final varTransactionProvider = context.read<VarTransactionProvider>();
    await varTransactionProvider.removeVarTransaction(id);

    widget.varTransaction.compensations?.remove(id);
    _varTransactions.removeWhere((v) => v.id == id);

    _loadVarTransactions();
  }

  Future<void> _updateVarTransaction(int id) async {
    final updated = await showDialog<bool>(
      context: context,
      builder: (_) => EditVarTransactionDialog(
        varTransaction: _varTransactions.firstWhere((v) => v.id == id),
      ),
    );
    if (!mounted) return;
    if (updated == true) {
      _loadVarTransactions();
    }
  }

  int _getFinalValue(VarTransaction t) {
    final compensationSum =
        t.compensations?.values.fold<int>(0, (sum, c) => sum + c.value) ?? 0;
    return t.value - compensationSum;
  }

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _isLoading
              ? const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      at.compensations,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_varTransactions.isEmpty)
                      SizedBox(
                        height: 100,
                        child: Center(child: Text(at.noItem(at.compensations))),
                      )
                    else
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: _varTransactions.map((t) {
                              final value = _getFinalValue(t);
                              final color = value > 0
                                  ? Colors.green[800]
                                  : Colors.red[800];
                              final compSum =
                                  t.compensations?.values.fold<int>(
                                    0,
                                    (sum, c) => sum + c.value,
                                  ) ??
                                  0;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 6.0,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        NumberFormat.currency(
                                          symbol: "€",
                                        ).format(value / 100),
                                        style: TextStyle(color: color),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    if (t.compensations != null)
                                      SizedBox(
                                        width: 120,
                                        child: Row(
                                          children: [
                                            CurrencyText(
                                              value: compSum / 100,
                                              isCompensation: true,
                                            ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.info,
                                                size: 18,
                                                color: Colors.blueGrey,
                                              ),
                                              onPressed: () async {
                                                await showDialog(
                                                  context: context,
                                                  builder: (_) =>
                                                      ShowCompensationsDialog(
                                                        varTransaction: t,
                                                      ),
                                                );
                                              },
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        '${at.topic}: ${widget.varTransaction.compensations![t.id]!.topicName}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        DateFormat.yMd().format(t.date),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                          onPressed: () =>
                                              _removeVarTransaction(t.id, context),
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        ),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 20,
                                          ),
                                          onPressed: () =>
                                              _updateVarTransaction(t.id),
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
                    const SizedBox(height: 16),

                    // --- CLOSE BUTTON ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(at.close),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
