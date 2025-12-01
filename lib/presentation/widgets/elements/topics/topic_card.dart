import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/currency_text.dart';
import 'package:organizer/presentation/widgets/dialogs/alert_delete.dart';
import 'package:provider/provider.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final VoidCallback? onDeleted;

  const TopicCard({super.key, required this.topic, this.onDeleted});

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final varTransactionProvider = context.read<VarTransactionProvider>();

    final topicTransactions = varTransactionProvider.varTransactions.where(
      (t) => t.topicId == topic.id,
    );

    final totalValue = topicTransactions.fold<int>(0, (sum, t) {
      final compSum =
          t.compensations?.values.fold<int>(0, (cSum, c) => cSum + c.value) ??
          0;
      return sum + (t.value - compSum);
    });

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.topic, arguments: topic),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final confirm = await AlertDelete.show(
                      context,
                      type: at.topic,
                      value: topic.name,
                    );
                    if (confirm == true) {
                      await context.read<TopicProvider>().removeTopic(topic.id);
                      // ignore: use_build_context_synchronously
                      await context.read<VarTransactionProvider>().reload();
                      onDeleted?.call();
                    }
                  },
                ),
              ),

              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      topic.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (topic.description != null &&
                        topic.description!.trim().isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          topic.description!,
                          style: theme.textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    const SizedBox(height: 8),
                    CurrencyText(
                      value: totalValue / 100,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
