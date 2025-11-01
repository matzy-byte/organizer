import 'package:flutter/material.dart';
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
  bool _isNew = false;

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
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionLabelProvider = context.read<TransactionLabelProvider>();

    return AlertDialog(
      title: _isNew
          ? const Text('Add Transaction Label')
          : const Text('Edit Transaction Label'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          onChanged: (value) => _validateForm(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Enter a name';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isFormValid
              ? () async {
                  if (widget.transactionLabel == null) {
                    transactionLabelProvider.addTransactionLabel(
                      _nameController.text,
                    );
                  } else {
                    transactionLabelProvider.updateTransactionLabel(
                      widget.transactionLabel!.id,
                      _nameController.text,
                    );
                  }
                  Navigator.pop(context, true);
                }
              : null,
          child: _isNew ? const Text('Add') : const Text('Save'),
        ),
      ],
    );
  }
}
