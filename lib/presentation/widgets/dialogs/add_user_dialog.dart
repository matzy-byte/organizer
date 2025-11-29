import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/core/utils/color_util.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:provider/provider.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({super.key});

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;
  final _nameController = TextEditingController();
  Color _selectedColor = Colors.blue;

  @override
  void initState() {
    super.initState();

    _selectedColor = ColorUtil.randomColor();

    WidgetsBinding.instance.addPostFrameCallback((_) => _validateForm());
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

  String get hexColor =>
      '#${_selectedColor.value.toRadixString(16).substring(2).toUpperCase()}';

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final userProvider = context.read<UserProvider>();
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
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: '${at.user} ${at.name}',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (_) => _validateForm(),
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? at.itemInvalid('${at.user} ${at.name}')
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () async {
                        final pickedColor = await showDialog<Color>(
                          context: context,
                          builder: (_) => Dialog(
                            insetPadding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(12),
                              child: SizedBox(
                                width: 500,
                                height: 250,
                                child: HueRingPicker(
                                  pickerColor: _selectedColor,
                                  onColorChanged: (color) =>
                                      setState(() => _selectedColor = color),
                                  enableAlpha: true,
                                  pickerAreaBorderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                ),
                              ),
                            ),
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
                          border: Border.all(color: Colors.black26),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
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
                              userProvider.addUser(
                                _nameController.text.trim(),
                                hexColor,
                              );
                              Navigator.pop(context, true);
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
