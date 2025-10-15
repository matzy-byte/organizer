import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';

class AddVarTransactionDialog extends StatefulWidget {
  final Topic? topic;
  const AddVarTransactionDialog({super.key, this.topic});

  @override
  State<AddVarTransactionDialog> createState() =>
      _AddVarTransactionDialogState();
}

class _AddVarTransactionDialogState extends State<AddVarTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();

  Category? _selectedCategory;
  Topic? _selectedTopic;
  Polarity _type = Polarity.negative;

  DateTime? _date;

  @override
  void initState() {
    super.initState();
    if (widget.topic != null) {
      _selectedCategory = widget.topic!.category;
      _selectedTopic = widget.topic;
    }
    _date = DateTime.now();
  }

  @override
  void dispose() {
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = now;
    final firstDate = DateTime(now.year - 10);
    final lastDate = DateTime(now.year + 10);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() => _date = picked);
      _validateForm();
    }
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
    final varTransactionProvider = context.read<VarTransactionProvider>();

    final categories = categoryProvider.categories;
    final topics = _selectedCategory == null
        ? <Topic>[]
        : topicProvider.topics
              .where((t) => t.category.id == _selectedCategory!.id)
              .toList();

    return AlertDialog(
      title: const Text('Add Fix Transaction'),
      content: categories.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<Category>(
                      initialValue: _selectedCategory,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: categories
                          .map(
                            (c) =>
                                DropdownMenuItem(value: c, child: Text(c.name)),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                          _selectedTopic = null;
                        });
                        _validateForm();
                      },
                      validator: (value) =>
                          value == null ? 'Please select a category' : null,
                    ),
                    if (_selectedCategory != null)
                      DropdownButtonFormField<Topic>(
                        initialValue: _selectedTopic,
                        decoration: const InputDecoration(labelText: 'Topic'),
                        items: topics
                            .map(
                              (t) => DropdownMenuItem(
                                value: t,
                                child: Text(t.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() => _selectedTopic = value);
                          _validateForm();
                        },
                        validator: (value) =>
                            value == null ? 'Please select a topic' : null,
                      ),
                    const SizedBox(height: 12),
                    SegmentedButton<Polarity>(
                      segments: const [
                        ButtonSegment(
                          value: Polarity.negative,
                          label: Text('Negative'),
                        ),
                        ButtonSegment(
                          value: Polarity.positive,
                          label: Text('Positive'),
                        ),
                      ],
                      selected: <Polarity>{_type},
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _type = newSelection.first;
                        });
                      },
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: _date == null
                            ? ''
                            : "${_date!.toLocal()}".split(' ')[0],
                      ),
                      onTap: () => _pickDate(context),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please select a start date'
                          : null,
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _valueController,
                      decoration: const InputDecoration(labelText: 'Value'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _validateForm(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter value';
                        }
                        final n = num.tryParse(value);
                        if (n == null) {
                          return 'Enter valid number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isFormValid
              ? () {
                final value = int.parse(_valueController.text);
                varTransactionProvider.addVarTransaction(
                  _selectedTopic!,
                  _type,
                  _date!,
                  value,
                  Compensation.none,
                  _descriptionController.value.text,
                );
                Navigator.pop(context);
              }
              : null,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
