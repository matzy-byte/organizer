import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final VoidCallback? onDeleted;

  const TopicCard({super.key, required this.topic, this.onDeleted});

  @override
  Widget build(BuildContext context) {
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

    final valueColor = totalValue >= 0 ? Colors.green : Colors.red;
    final formattedValue = NumberFormat.currency(
      symbol: "€",
    ).format(totalValue / 100);

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
                    await context.read<TopicProvider>().removeTopic(topic.id);
                    await context.read<VarTransactionProvider>().reload();
                    onDeleted?.call();
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
                    Text(
                      formattedValue,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: valueColor,
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
