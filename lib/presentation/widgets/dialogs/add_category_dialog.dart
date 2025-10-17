import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:provider/provider.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<CategoryProvider>();

    return AlertDialog(
      title: const Text('Add Category'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Category name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(hintText: 'Category decription'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            final name = _nameController.text.trim();
            final description = _descriptionController.text.trim();
            if (name.isNotEmpty) {
              categoryProvider.addCategory(name, description);
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
    super.dispose();
  }
}
