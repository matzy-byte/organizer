import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final String name;
  final String? description;

  const TopicCard({super.key, required this.name, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(name),
                  if (description != null) Text(description!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
