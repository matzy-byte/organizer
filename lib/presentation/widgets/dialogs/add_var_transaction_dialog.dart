import 'package:flutter/material.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';

class AddVarTransactionDialog extends StatefulWidget {
  final Category? category;
  final Topic? topic;
  const AddVarTransactionDialog({super.key, this.category, this.topic});

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
  List<Category> _categories = [];
  Topic? _selectedTopic;
  List<Topic> _topics = [];
  List<Topic> _allTopics = [];
  bool _isExpense = true;

  DateTime? _date;

  List<_CompensationEntry> _compensations = [];

  @override
  void initState() {
    super.initState();

    final categoryProvider = context.read<CategoryProvider>();
    final topicProvider = context.read<TopicProvider>();
    _categories = categoryProvider.categories;
    _allTopics = topicProvider.topics;

    if (widget.topic != null) {
      _selectedCategory = _categories.firstWhere(
        (c) => c.id == widget.topic!.categoryId,
      );
      _topics = topicProvider.topics
          .where((t) => t.categoryId == _selectedCategory!.id)
          .toList();
      _selectedTopic = _topics.firstWhere((t) => t.id == widget.topic!.id);
    } else if (widget.category != null) {
      _selectedCategory = _categories.firstWhere(
        (c) => c.id == widget.category!.id,
      );
      _topics = topicProvider.topics
          .where((t) => t.categoryId == _selectedCategory!.id)
          .toList();
    }

    _date = DateTime.now();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _validateForm();
    });
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
    final topicProvider = context.read<TopicProvider>();
    final varTransactionProvider = context.read<VarTransactionProvider>();

    return AlertDialog(
      title: const Text('Add Var Transaction'),
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
                      onChanged: (value) async {
                        final topics = await topicProvider.loadTopicsByCategory(
                          value!.id,
                        );
                        setState(() {
                          _selectedCategory = value;
                          _topics = topics;
                          _selectedTopic = null;
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _validateForm();
                        });
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
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment(value: true, label: Text('Negative')),
                        ButtonSegment(value: false, label: Text('Positive')),
                      ],
                      selected: <bool>{_isExpense},
                      onSelectionChanged: (newSelection) {
                        setState(() {
                          _isExpense = newSelection.first;
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
                    ExpansionTile(
                      title: const Text('Compensations'),
                      children: [
                        ..._compensations.asMap().entries.map((entry) {
                          final index = entry.key;
                          final comp = entry.value;

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: DropdownButtonFormField<Topic>(
                                    initialValue: comp.topic,
                                    decoration: const InputDecoration(
                                      labelText: 'Topic',
                                    ),
                                    items: _allTopics
                                        .map(
                                          (t) => DropdownMenuItem(
                                            value: t,
                                            child: Text(
                                              "${_categories.firstWhere((c) => c.id == t.categoryId).name}/${t.name}",
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() => comp.topic = value);
                                      _validateForm();
                                    },
                                    validator: (value) =>
                                        value == null ? 'Select a topic' : null,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    controller: comp.valueController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Value',
                                    ),
                                    onChanged: (value) => _validateForm(),
                                    validator: (v) {
                                      if (v == null || v.isEmpty) {
                                        return 'Enter value';
                                      }
                                      if (num.tryParse(v) == null) {
                                        return 'Invalid number';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      _compensations.removeAt(index);
                                    });
                                    _validateForm();
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _compensations.add(_CompensationEntry());
                              });
                            },
                            icon: const Icon(Icons.add),
                            label: const Text('Add Compensation'),
                          ),
                        ),
                      ],
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
              ? () async {
                  final Map<int, CompensationInfo> compensationsMap = {};
                  for (final c in _compensations) {
                    final value = int.parse(c.valueController.text);
                    final compId = await varTransactionProvider
                        .addVarTransaction(
                          c.topic!.id,
                          _date!,
                          _isExpense ? -1 * value : value,
                          null,
                          "Compensation: ${_descriptionController.text}",
                          null,
                          null,
                        );

                    compensationsMap[compId] = CompensationInfo(
                      topicId: c.topic!.id,
                      topicName: c.topic!.name,
                      value: _isExpense ? -1 * value : value,
                    );
                  }

                  final value = int.parse(_valueController.text);
                  final varTransactionId = await varTransactionProvider
                      .addVarTransaction(
                        _selectedTopic!.id,
                        _date!,
                        _isExpense ? -1 * value : value,
                        compensationsMap.isEmpty ? null : compensationsMap,
                        _descriptionController.value.text.isEmpty ? null : _descriptionController.value.text,
                        null,
                        null,
                      );

                  for (final id in compensationsMap.keys) {
                    await varTransactionProvider.setVarReference(
                      id,
                      varTransactionId,
                    );
                  }
                  Navigator.pop(context, true);
                }
              : null,
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class _CompensationEntry {
  Topic? topic;
  TextEditingController valueController = TextEditingController();

  _CompensationEntry();
}
