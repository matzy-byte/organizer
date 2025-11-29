import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/app/defaults.dart';
import 'package:organizer/core/models/var_transaction.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/main.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/show_compensations_dialog.dart';
import 'package:organizer/presentation/widgets/elements/users/user_icon.dart';
import 'package:provider/provider.dart';

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
    final at = AppLocalizations.of(context)!;
    
    if (varTransactions.isEmpty) {
      return Center(child: Text(at.noItem(at.transactions)));
    }

    final userProvider = context.read<UserProvider>();
    final transactionLabelProvider = context.read<TransactionLabelProvider>();

    final width = MediaQuery.of(context).size.width;

    final isMobile = width < Defaults.maxMobileWidth;
    final isTablet =
        width >= Defaults.maxMobileWidth && width < Defaults.maxTabletWidth;

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: varTransactions.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey.shade300, height: 1),
      itemBuilder: (context, index) {
        final t = varTransactions[index];
        final u = userProvider.users.firstWhere((u) => u.id == t.userRefId);
        final value = getFinalValue(t);

        final valueText = Text(
          NumberFormat.currency(symbol: "€").format(value / 100),
          style: TextStyle(
            color: value > 0
                ? const Color(0xFF006400)
                : const Color(0xFF8B0000),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        );

        final compensationSum =
            t.compensations?.values.fold<int>(0, (sum, c) => sum + c.value) ??
            0;

        final compensationText = Text(
          '(${NumberFormat.currency(symbol: "€").format(compensationSum / 100)})',
          style: TextStyle(
            color: t.value > 0
                ? const Color(0xFF006400)
                : const Color(0xFF8B0000),
          ),
        );

        final compensationIcon = IconButton(
          onPressed: () async => await showDialog(
            context: context,
            builder: (context) => ShowCompensationsDialog(varTransaction: t),
          ),
          padding: EdgeInsets.all(5),
          icon: Icon(Icons.info, size: 20),
          constraints: const BoxConstraints(),
        );

        final labelChip = t.transactionLabelId != null
            ? Chip(
                label: Text(
                  transactionLabelProvider.transactionLabels
                          .where((l) => l.id == t.transactionLabelId)
                          .firstOrNull
                          ?.name ??
                      at.loading,
                ),
              )
            : null;

        final dateText = Text(DateFormat.yMd().format(t.date));

        final actions = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, size: 20),
              onPressed: () => delete.call(t.id),
              padding: EdgeInsets.all(5),
              constraints: const BoxConstraints(),
            ),
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => edit.call(t.id),
              padding: EdgeInsets.all(5),
              constraints: const BoxConstraints(),
            ),
          ],
        );

        final userIcon = UserIcon(user: u, size: 18);

        // ---------------- MOBILE ----------------
        if (isMobile) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 70, child: valueText),
                    const SizedBox(width: 4),
                    if (t.compensations != null) ...[
                      compensationIcon,
                      const SizedBox(width: 4),
                    ],
                    Expanded(child: dateText),
                    actions,
                  ],
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    SizedBox(width: 70, child: userIcon),
                    const SizedBox(width: 8),

                    if (labelChip != null) ...[
                      labelChip,
                      const SizedBox(width: 8),
                    ],

                    Expanded(
                      child: Text(
                        t.description ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        // ---------------- TABLET ----------------
        if (isTablet) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 70, child: valueText),
                const SizedBox(width: 4),
                if (t.compensations != null) ...[
                  compensationText,
                  const SizedBox(width: 4),
                  compensationIcon,
                  const SizedBox(width: 4),
                ],
                if (labelChip != null) ...[labelChip, const SizedBox(width: 8)],
                Expanded(
                  child: Text(
                    t.description ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                dateText,
                const SizedBox(width: 4),
                actions,
                const SizedBox(width: 4),
                userIcon,
              ],
            ),
          );
        }

        // ---------------- DESKTOP ----------------
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 70, child: valueText),
              const SizedBox(width: 4),
              if (t.compensations != null) ...[
                compensationText,
                const SizedBox(width: 4),
                compensationIcon,
                const SizedBox(width: 4),
              ],
              if (labelChip != null) ...[labelChip, const SizedBox(width: 8)],
              Expanded(
                child: Text(
                  t.description ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              dateText,
              const SizedBox(width: 4),
              actions,
              const SizedBox(width: 4),
              userIcon,
            ],
          ),
        );
      },
    );
  }

  int getFinalValue(VarTransaction varTransaction) {
    final compensations = varTransaction.compensations;
    if (compensations == null) return varTransaction.value;

    final compensationSum = compensations.values.fold<int>(
      0,
      (sum, c) => sum + c.value,
    );

    return varTransaction.value - compensationSum;
  }
}
