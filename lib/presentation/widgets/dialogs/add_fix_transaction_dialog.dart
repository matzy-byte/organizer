import 'package:flutter/material.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:provider/provider.dart';

class AddFixTransactionDialog extends StatefulWidget {
  final Topic topic;
  const AddFixTransactionDialog({super.key, required this.topic});

  @override
  State<AddFixTransactionDialog> createState() => _AddFixTransactionDialogState();
}

class _AddFixTransactionDialogState extends State<AddFixTransactionDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedTopic;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.topic.category.name;
    _selectedTopic = widget.topic.name;
  }

  @override
  Widget build(BuildContext context) {
    final topicProvider = context.read<TopicProvider>();
    final categoryProvider = context.read<CategoryProvider>();

    return AlertDialog(
      title: const Text('Add Topic'),
      content: categoryProvider.categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _selectedTopic,
                  hint: const Text('Select category'),
                  items: categoryProvider.categories
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.name,
                          child: Text(c.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() => _selectedTopic = value);
                  },
                ),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Topic name'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Topic description',
                  ),
                ),
              ],
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: categoryProvider.categories.isEmpty
              ? null
              : () async {
                  final name = _nameController.text.trim();
                  final description = _descriptionController.text.trim();
                  if (name.isNotEmpty && _selectedTopic != null) {
                    await topicProvider.addTopic(
                      categoryProvider.categories.firstWhere(
                        (c) => c.name == _selectedTopic,
                      ),
                      name,
                      description.isEmpty ? null : description,
                    );
                    Navigator.pop(context);
                  }
                },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
