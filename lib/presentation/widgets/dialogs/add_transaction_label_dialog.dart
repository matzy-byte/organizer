import 'package:flutter/material.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:provider/provider.dart';

class AddTransactionLabelDialog extends StatefulWidget {
  final TransactionLabel? transactionLabel;

  const AddTransactionLabelDialog({super.key, this.transactionLabel});

  @override
  State<AddTransactionLabelDialog> createState() =>
      _AddTransactionLabelDialogState();
}

class _AddTransactionLabelDialogState extends State<AddTransactionLabelDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  late bool _isNew;

  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isNew = widget.transactionLabel == null;
    _nameController.text = _isNew ? '' : widget.transactionLabel!.name;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transactionLabelProvider = context.read<TransactionLabelProvider>();
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
                  _isNew ? 'Add Transaction Label' : 'Edit Transaction Label',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: setupTheme.sectionSpacing),

                // --- NAME FIELD ---
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (_) => _validateForm(),
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Enter a name' : null,
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
                          ? () async {
                              if (_isNew) {
                                transactionLabelProvider.addTransactionLabel(
                                  _nameController.text.trim(),
                                );
                              } else {
                                transactionLabelProvider.updateTransactionLabel(
                                  widget.transactionLabel!.id,
                                  _nameController.text.trim(),
                                );
                              }
                              Navigator.pop(context, true);
                            }
                          : null,
                      child: Text(_isNew ? 'Add' : 'Save'),
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
