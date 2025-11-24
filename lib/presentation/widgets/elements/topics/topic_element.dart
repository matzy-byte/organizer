import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/widgets/elements/topics/topic_card.dart';
import 'package:provider/provider.dart';

class TopicElement extends StatelessWidget {
  final categoryId;
  const TopicElement({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<TopicProvider>().topics.where(
      (t) => t.categoryId == categoryId,
    );
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Topics',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (items.isEmpty)
                Center(
                  child: Text(
                    'No Topics found',
                    style: theme.textTheme.bodyMedium,
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = 8.0;
                    const maxWidth = 260.0;

                    final perRow = (constraints.maxWidth / (maxWidth + spacing))
                        .floor()
                        .clamp(1, items.length);

                    final cardWidth =
                        (constraints.maxWidth - (spacing * (perRow - 1))) /
                        perRow;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      alignment: WrapAlignment.center,
                      children: items.map((t) {
                        return SizedBox(
                          width: cardWidth,
                          height: 250,
                          child: TopicCard(topic: t),
                        );
                      }).toList(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
