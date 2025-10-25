import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:provider/provider.dart';

class AddTopicDialog extends StatefulWidget {
  final Category? category;
  const AddTopicDialog({super.key, this.category});

  @override
  State<AddTopicDialog> createState() => _AddTopicDialogState();
}

class _AddTopicDialogState extends State<AddTopicDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category?.name;
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<CategoryProvider>();
    final topicProvider = context.read<TopicProvider>();

    return AlertDialog(
      title: const Text('Add Topic'),
      content: categoryProvider.categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  value: _selectedCategory,
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
                    setState(() => _selectedCategory = value);
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
                  if (name.isNotEmpty && _selectedCategory != null) {
                    await topicProvider.addTopic(
                      categoryProvider.categories
                          .firstWhere((c) => c.name == _selectedCategory)
                          .id,
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
