import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:provider/provider.dart';

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final categoryProvider = context.watch<CategoryProvider>();
    final topicProvider = context.watch<TopicProvider>();

    return Container(
      color: theme.colorScheme.surface,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(context, theme),

          ListTile(
            leading: Icon(Icons.dashboard, color: theme.colorScheme.primary),
            title: Text(at.dashboard, style: theme.textTheme.titleMedium),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.dashboard);
            },
          ),
          const Divider(height: 1),

          ...categoryProvider.categories.map((category) {
            final topics = topicProvider.topics
                .where((t) => t.categoryId == category.id)
                .toList();

            return _CustomExpandableCategoryTile(
              category: category,
              topics: topics,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    final at = AppLocalizations.of(context)!;
    
    return DrawerHeader(
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          at.categories,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CustomExpandableCategoryTile extends StatefulWidget {
  final Category category;
  final List<Topic> topics;

  const _CustomExpandableCategoryTile({
    required this.category,
    required this.topics,
  });

  @override
  State<_CustomExpandableCategoryTile> createState() =>
      _CustomExpandableCategoryTileState();
}

class _CustomExpandableCategoryTileState
    extends State<_CustomExpandableCategoryTile> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasTopics = widget.topics.isNotEmpty;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(Icons.folder, color: theme.colorScheme.primary),
                title: Text(
                  widget.category.name,
                  style: theme.textTheme.titleMedium,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    AppRoutes.category,
                    arguments: widget.category,
                  );
                },
              ),
            ),

            if (hasTopics)
              IconButton(
                splashRadius: 20,
                icon: AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: expanded ? 0.25 : 0,
                  child: const Icon(Icons.arrow_right),
                ),
                onPressed: () {
                  setState(() => expanded = !expanded);
                },
              ),
          ],
        ),

        if (expanded)
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              children: widget.topics
                  .map(
                    (topic) => ListTile(
                      dense: true,
                      leading: Icon(
                        Icons.circle,
                        size: 10,
                        color: theme.colorScheme.primary,
                      ),
                      title: Text(topic.name, style: theme.textTheme.bodyLarge),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          AppRoutes.topic,
                          arguments: topic,
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
