import 'package:flutter/material.dart';
import 'package:organizer/app/themes/setup_theme_extension.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final List<Widget> children;
  final VoidCallback onDelete;
  final VoidCallback onAddTopic;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.children,
    required this.onDelete,
    required this.onAddTopic,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<SetupTheme>()!;

    return Card(
      child: Padding(
        padding: theme.cardPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  categoryName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 8),
                IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
              ],
            ),
            SizedBox(height: theme.itemSpacing),
            ...children,
            SizedBox(height: theme.itemSpacing),
            IconButton(onPressed: onAddTopic, icon: const Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
