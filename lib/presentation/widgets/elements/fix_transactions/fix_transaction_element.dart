import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/edit_fix_transaction_dialog.dart';
import 'package:organizer/presentation/widgets/elements/fix_transactions/fix_transaction_active_card.dart';
import 'package:organizer/presentation/widgets/elements/fix_transactions/fix_transaction_inactive_table.dart';
import 'package:provider/provider.dart';

class FixTransactionElement extends StatelessWidget {
  const FixTransactionElement({super.key});

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final provider = context.watch<FixTransactionProvider>();
    final items = provider.fixTransactions;

    final active = items.where((f) => f.status == Status.active).toList();
    final inactive = items.where((f) => f.status == Status.inactive).toList();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${at.repeated} ${at.transactions}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                _ActiveSection(active: active),

                if (inactive.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  _InactiveSection(inactive: inactive),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ActiveSection extends StatelessWidget {
  final List<FixTransaction> active;

  const _ActiveSection({required this.active});

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;

    if (active.isEmpty) {
      return Center(
        child: Text(
          at.noItem('${at.active} ${at.transactions}'),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 8.0;
        const maxWidth = 260.0;

        final perRow = (constraints.maxWidth / (maxWidth + spacing))
            .floor()
            .clamp(1, active.length);

        final cardWidth =
            (constraints.maxWidth - (spacing * (perRow - 1))) / perRow;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: active
              .map(
                (f) => SizedBox(
                  width: cardWidth,
                  child: FixTransactionActiveCard(
                    fixTransaction: f,
                    edit: (id) async {
                      final f = active.firstWhereOrNull((f) => f.id == id);
                      if (f == null) return;

                      await showDialog(
                        context: context,
                        builder: (context) =>
                            EditFixTransactionDialog(fixTransaction: f),
                      );
                      // ignore: use_build_context_synchronously
                      context.read<FixTransactionProvider>().reload();
                    },
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _InactiveSection extends StatefulWidget {
  final List<FixTransaction> inactive;

  const _InactiveSection({required this.inactive});

  @override
  State<_InactiveSection> createState() => _InactiveSectionState();
}

class _InactiveSectionState extends State<_InactiveSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${at.inactive} ${at.transactions}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded) ...[
          const SizedBox(height: 8),
          FixTransactionInactiveTable(
            fixTransactions: widget.inactive,
            edit: (id) async {
              final f = widget.inactive.firstWhereOrNull((f) => f.id == id);
              if (f == null) return;

              await showDialog(
                context: context,
                builder: (context) =>
                    EditFixTransactionDialog(fixTransaction: f),
              );
            },
            delete: (id) async {
              final fixTransactionProvider = context.read<FixTransactionProvider>();
              await fixTransactionProvider.removeFixTransaction(id);
              // ignore: use_build_context_synchronously
              await context.read<VarTransactionProvider>().reload();
            },
          ),
        ],
      ],
    );
  }
}
