import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/add_category_dialog.dart';
import 'package:organizer/presentation/widgets/dialogs/add_topic_dialog.dart';
import 'package:provider/provider.dart';

class StructureSetup extends StatelessWidget {
  const StructureSetup({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = context.watch<CategoryProvider>();
    TopicProvider topicProvider = context.watch<TopicProvider>();
    return Wrap(
      children: [
        ...categoryProvider.categories.map(
          (c) => Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(c.name),
                    IconButton(
                      onPressed: () async =>
                          await categoryProvider.removeCategory(c),
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ...topicProvider.topics
                        .where((t) => t.categoryId == c.id)
                        .map(
                          (t) => Row(
                            children: [
                              Text(t.name),
                              IconButton(
                                onPressed: () async =>
                                    await topicProvider.removeTopic(t.id),
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                  ],
                ),
                IconButton(
                  onPressed: () async => await showDialog(
                    context: context,
                    builder: (context) => AddTopicDialog(category: c),
                  ),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: () async => await showDialog(
            context: context,
            builder: (context) => AddCategoryDialog(),
          ),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
