import 'package:flutter/material.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  Category? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.category;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = context.read<CategoryProvider>();
    final topicProvider = context.read<TopicProvider>();
    final theme = Theme.of(context);
    final setupTheme = theme.extension<SetupTheme>()!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: setupTheme.cardPadding,
          child: categoryProvider.categories.isEmpty
              ? SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // --- TITLE ---
                      Text(
                        'Add Topic',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: setupTheme.sectionSpacing),

                      // --- CATEGORY DROPDOWN ---
                      DropdownButtonFormField<Category>(
                        initialValue: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Select Category',
                          border: OutlineInputBorder(),
                        ),
                        items: categoryProvider.categories
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedCategory = value);
                          _validateForm();
                        },
                        validator: (value) =>
                            value == null ? 'Please select a category' : null,
                      ),
                      SizedBox(height: setupTheme.itemSpacing),

                      // --- TOPIC NAME ---
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Topic Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _validateForm(),
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? 'Please enter a topic name'
                            : null,
                      ),
                      SizedBox(height: setupTheme.itemSpacing),

                      // --- TOPIC DESCRIPTION ---
                      TextFormField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: setupTheme.sectionSpacing),

                      // --- ACTION BUTTONS ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _isFormValid
                                ? () {
                                    final selectedCat = categoryProvider
                                        .categories
                                        .firstWhere(
                                          (c) => c.id == _selectedCategory!.id,
                                        );
                                    topicProvider.addTopic(
                                      selectedCat.id,
                                      _nameController.text.trim(),
                                      _descriptionController.text.trim().isEmpty
                                          ? null
                                          : _descriptionController.text.trim(),
                                    );
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
