import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:provider/provider.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;
  final VoidCallback? onDeleted;

  const TopicCard({super.key, required this.topic, this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(context, AppRoutes.topic, arguments: topic),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(topic.name),
                    if (topic.description != null) Text(topic.description!),
                    IconButton(
                      onPressed: () => removeTopic(context),
                      icon: Icon(Icons.delete),
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

  void removeTopic(BuildContext context) {
    final topicProvider = context.read<TopicProvider>();
    topicProvider.removeTopic(topic);
    onDeleted?.call();
  }
}
