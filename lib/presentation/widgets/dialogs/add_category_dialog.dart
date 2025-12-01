import 'package:flutter/material.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:provider/provider.dart';

class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _firstFieldFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
      _firstFieldFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _firstFieldFocusNode.dispose();
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
    final at = AppLocalizations.of(context)!;
    final categoryProvider = context.read<CategoryProvider>();
    final theme = Theme.of(context);
    final setupTheme = theme.extension<SetupTheme>()!;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: setupTheme.cardPadding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // --- TITLE ---
                Text(
                  '${at.add} ${at.category}',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: setupTheme.sectionSpacing),

                // --- NAME FIELD ---
                TextFormField(
                  focusNode: _firstFieldFocusNode,
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '${at.category} ${at.name}',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) => _validateForm(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return at.itemInvalid(at.name);
                    }
                    return null;
                  },
                ),
                SizedBox(height: setupTheme.itemSpacing),

                // --- DESCRIPTION FIELD ---
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: at.description,
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
                      child: Text(at.cancel),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _isFormValid
                          ? () {
                              categoryProvider.addCategory(
                                _nameController.text.trim(),
                                _descriptionController.text.trim(),
                              );
                              Navigator.pop(context);
                            }
                          : null,
                      child: Text(at.add),
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
