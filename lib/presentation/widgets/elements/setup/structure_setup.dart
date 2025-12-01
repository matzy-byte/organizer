import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_topic_dialog.dart';
import 'package:organizer/presentation/widgets/elements/setup/sub_elements/category_card.dart';
import 'package:organizer/presentation/widgets/elements/setup/sub_elements/setup_item_row.dart';
import 'package:organizer/presentation/widgets/elements/setup/sub_elements/setup_section.dart';
import 'package:provider/provider.dart';

class StructureSetup extends StatelessWidget {
  const StructureSetup({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.watch<CategoryProvider>();
    final topicProvider = context.watch<TopicProvider>();

    return SetupSection(
      title: 'Categories',
      onAdd: () => showDialog(
        context: context,
        builder: (_) => const AddCategoryDialog(),
      ),
      children: [
        ...categoryProvider.categories.map(
          (c) => CategoryCard(
            categoryName: c.name,
            onDelete: () => categoryProvider.removeCategory(c),
            onAddTopic: () => showDialog(
              context: context,
              builder: (_) => AddTopicDialog(category: c),
            ),
            children: topicProvider.topics
                .where((t) => t.categoryId == c.id)
                .map(
                  (t) => SetupItemRow(
                    text: t.name,
                    onDelete: () => topicProvider.removeTopic(t.id),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
