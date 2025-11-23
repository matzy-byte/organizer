import 'package:flutter/material.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/core/utils/color_util.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/widgets/color_wheel.dart';
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
  Color _selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    _isNew = widget.transactionLabel == null;

    _nameController.text = _isNew ? '' : widget.transactionLabel!.name;
    _selectedColor = _isNew
        ? ColorUtil.randomColor()
        : ColorUtil.colorFromHexCode(widget.transactionLabel!.color);

    WidgetsBinding.instance.addPostFrameCallback((_) => _validateForm());
  }

  void _validateForm() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid != _isFormValid) setState(() => _isFormValid = valid);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  String get hexColor =>
      '#${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}';

  @override
  Widget build(BuildContext context) {
    final provider = context.read<TransactionLabelProvider>();
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
                Text(
                  _isNew ? 'Add Transaction Label' : 'Edit Transaction Label',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: setupTheme.sectionSpacing),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) => _validateForm(),
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Enter a name'
                            : null,
                      ),
                    ),

                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () async {
                        final pickedColor = await showDialog<Color>(
                          context: context,
                          builder: (_) => SizedBox(
                            width: 250,
                            height: 250,
                            child: ColorWheelDialog(color: _selectedColor),
                          ),
                        );

                        if (pickedColor != null) {
                          setState(() => _selectedColor = pickedColor);
                        }
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: _selectedColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.outline,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: setupTheme.sectionSpacing * 1.5),
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
                                provider.addTransactionLabel(
                                  _nameController.text.trim(),
                                  hexColor,
                                );
                              } else {
                                provider.updateTransactionLabel(
                                  widget.transactionLabel!.id,
                                  _nameController.text.trim(),
                                  hexColor,
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
