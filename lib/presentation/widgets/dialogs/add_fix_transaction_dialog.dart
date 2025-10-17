import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/compensation.dart';
import 'package:organizer/core/models/polarity.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:provider/provider.dart';

class AddFixTransactionDialog extends StatefulWidget {
  final Category? category;
  final Topic? topic;
  const AddFixTransactionDialog({super.key, this.category, this.topic});

  @override
  State<AddFixTransactionDialog> createState() =>
      _AddFixTransactionDialogState();
}

class _AddFixTransactionDialogState extends State<AddFixTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  final _intervalController = TextEditingController();
  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();

  Category? _selectedCategory;
  List<Category> _categories = [];
  Topic? _selectedTopic;
  List<Topic> _topics = [];
  Status _status = Status.active;
  Polarity _type = Polarity.negative;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();

    final categoryProvider = context.read<CategoryProvider>();
    final topicProvider = context.read<TopicProvider>();
    _categories = categoryProvider.categories;

    if (widget.topic != null) {
      _selectedCategory = _categories.firstWhere((c) => c.id == widget.topic!.category.id);
      _topics = topicProvider.topics.where((t) => t.category.id == _selectedCategory!.id).toList();
      _selectedTopic = _topics.firstWhere((t) => t.id == widget.topic!.id);
    } else if (widget.category != null) {
      _selectedCategory = _categories.firstWhere((c) => c.id == widget.category!.id);
    }

    _startDate = DateTime.now();
    _endDate = DateTime.now();
  }

  @override
  void dispose() {
    _intervalController.dispose();
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final now = DateTime.now();
    final initialDate = isStart ? (_startDate ?? now) : (_endDate ?? now);
    final firstDate = DateTime(now.year - 10);
    final lastDate = DateTime(now.year + 10);

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = picked;
          }
        } else {
          _endDate = picked;
          if (_startDate != null && _startDate!.isAfter(picked)) {
            _startDate = picked;
          }
        }
      });
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
    final fixTransactionProvider = context.read<FixTransactionProvider>();

    return AlertDialog(
      title: const Text('Add Fix Transaction'),
      content: _categories.isEmpty
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
                      items: _categories
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
                        items: _topics
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
                    SegmentedButton<Status>(
                      segments: const [
                        ButtonSegment(
                          value: Status.active,
                          label: Text('Active'),
                        ),
                        ButtonSegment(
                          value: Status.inactive,
                          label: Text('Inactive'),
                        ),
                      ],
                      selected: <Status>{_status},
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _status = newSelection.first;
                        });
                      },
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
                        labelText: 'Start Date',
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: _startDate == null
                            ? ''
                            : "${_startDate!.toLocal()}".split(' ')[0],
                      ),
                      onTap: () => _pickDate(context, true),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please select a start date'
                          : null,
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'End Date',
                        suffixIcon: const Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: _endDate == null
                            ? ''
                            : "${_endDate!.toLocal()}".split(' ')[0],
                      ),
                      onTap: () => _pickDate(context, false),
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please select an end date'
                          : null,
                    ),

                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _intervalController,
                      decoration: const InputDecoration(labelText: 'Interval'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _validateForm(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter interval';
                        }
                        final n = int.tryParse(value);
                        if (n == null || n <= 0) {
                          return 'Enter valid positive number';
                        }
                        return null;
                      },
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
                final interval = int.parse(_intervalController.text);
                final value = int.parse(_valueController.text);
                fixTransactionProvider.addFixTransaction(
                  _selectedTopic!,
                  _status,
                  _type,
                  _startDate!,
                  _endDate!,
                  interval,
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
