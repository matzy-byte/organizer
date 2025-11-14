import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/fix_transaction.dart';
import 'package:organizer/core/models/interval_unit.dart';
import 'package:organizer/core/models/status.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/manage_transaction_labels_dialog.dart';
import 'package:provider/provider.dart';

class EditFixTransactionDialog extends StatefulWidget {
  final FixTransaction fixTransaction;
  const EditFixTransactionDialog({super.key, required this.fixTransaction});

  @override
  State<EditFixTransactionDialog> createState() =>
      _EditFixTransactionDialogState();
}

class _EditFixTransactionDialogState extends State<EditFixTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  bool _isFormValid = false;

  final _intervalCountController = TextEditingController();
  final _valueController = TextEditingController();
  final _descriptionController = TextEditingController();

  Category? _selectedCategory;
  List<Category> _categories = [];
  Topic? _selectedTopic;
  List<Topic> _topics = [];
  List<Topic> _allTopics = [];
  Status _status = Status.active;
  bool _isExpense = true;

  DateTime? _startDate;
  DateTime? _endDate;

  IntervalUnit? _selectedIntervalUnit = IntervalUnit.month;

  List<_CompensationEntry> _compensations = [];

  TransactionLabel? _selectedTransactionLabel;

  @override
  void initState() {
    super.initState();

    final transactionLabelProvider = context.read<TransactionLabelProvider>();
    final categoryProvider = context.read<CategoryProvider>();
    final topicProvider = context.read<TopicProvider>();
    _categories = categoryProvider.categories;
    _allTopics = topicProvider.topics;

    _selectedTopic = _allTopics.firstWhereOrNull(
      (t) => t.id == widget.fixTransaction.topicId,
    );
    _selectedCategory = _categories.firstWhereOrNull(
      (c) => c.id == _selectedTopic!.categoryId,
    );
    _topics = _allTopics
        .where((t) => t.categoryId == _selectedCategory!.id)
        .toList();

    _isExpense = widget.fixTransaction.value < 0;
    _status = widget.fixTransaction.status;
    _startDate = widget.fixTransaction.start;
    _endDate = widget.fixTransaction.end;
    _intervalCountController.text = widget.fixTransaction.intervalCount
        .toString();
    _selectedIntervalUnit = widget.fixTransaction.intervalUnit;
    _selectedTransactionLabel = transactionLabelProvider.transactionLabels
        .firstWhereOrNull(
          (l) => l.id == widget.fixTransaction.transactionLabelId,
        );
    _valueController.text = widget.fixTransaction.value.abs().toString();
    _descriptionController.text = widget.fixTransaction.description ?? '';

    if (widget.fixTransaction.compensations != null) {
      for (final e in widget.fixTransaction.compensations!.entries) {
        final topic = _allTopics.firstWhere((t) => t.id == e.value.topicId);
        _compensations.add(
          _CompensationEntry.withData(topic, e.value.value.abs().toString()),
        );
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => _validateForm());
  }

  @override
  void dispose() {
    _intervalCountController.dispose();
    _valueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final now = DateTime.now();
    final initialDate = isStart ? (_startDate ?? now) : (_endDate ?? now);
    final firstDate = DateTime(now.year - 99);
    final lastDate = DateTime(now.year + 99);

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
          if (_endDate != null && _endDate!.isBefore(picked)) _endDate = picked;
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
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final setupTheme = theme.extension<SetupTheme>()!;
    final transactionLabelProvider = context.read<TransactionLabelProvider>();
    final topicProvider = context.read<TopicProvider>();
    final fixTransactionProvider = context.read<FixTransactionProvider>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _categories.isEmpty
              ? const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // --- TITLE ---
                        Text(
                          'Edit Fix Transaction',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- CATEGORY ---
                        DropdownButtonFormField<Category>(
                          initialValue: _selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            border: OutlineInputBorder(),
                          ),
                          items: _categories
                              .map(
                                (c) => DropdownMenuItem(
                                  value: c,
                                  child: Text(c.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) async {
                            final topics = await topicProvider
                                .loadTopicsByCategory(value!.id);
                            setState(() {
                              _selectedCategory = value;
                              _topics = topics;
                              _selectedTopic = null;
                            });
                            WidgetsBinding.instance.addPostFrameCallback(
                              (_) => _validateForm(),
                            );
                          },
                          validator: (v) =>
                              v == null ? 'Please select a category' : null,
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- TOPIC ---
                        if (_selectedCategory != null)
                          DropdownButtonFormField<Topic>(
                            initialValue: _selectedTopic,
                            decoration: const InputDecoration(
                              labelText: 'Topic',
                              border: OutlineInputBorder(),
                            ),
                            items: _topics
                                .map(
                                  (t) => DropdownMenuItem(
                                    value: t,
                                    child: Text(t.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              setState(() => _selectedTopic = v);
                              _validateForm();
                            },
                            validator: (v) =>
                                v == null ? 'Please select a topic' : null,
                          ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- STATUS SEGMENTED ---
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
                          selected: {_status},
                          onSelectionChanged: (s) =>
                              setState(() => _status = s.first),
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- EXPENSE SEGMENTED ---
                        SegmentedButton<bool>(
                          segments: const [
                            ButtonSegment(value: true, label: Text('Negative')),
                            ButtonSegment(
                              value: false,
                              label: Text('Positive'),
                            ),
                          ],
                          selected: {_isExpense},
                          onSelectionChanged: (s) =>
                              setState(() => _isExpense = s.first),
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- DATES ---
                        TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Start Date',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(
                            text: _startDate == null
                                ? ''
                                : "${_startDate!.toLocal()}".split(' ')[0],
                          ),
                          onTap: () => _pickDate(context, true),
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please select a start date'
                              : null,
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),
                        TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'End Date',
                            suffixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder(),
                          ),
                          controller: TextEditingController(
                            text: _endDate == null
                                ? ''
                                : "${_endDate!.toLocal()}".split(' ')[0],
                          ),
                          onTap: () => _pickDate(context, false),
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Please select an end date'
                              : null,
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- INTERVAL ---
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: _intervalCountController,
                                decoration: const InputDecoration(
                                  labelText: 'Interval Count',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (_) => _validateForm(),
                                validator: (v) {
                                  if (v == null || v.isEmpty) {
                                    return 'Enter interval';
                                  }
                                  final n = int.tryParse(v);
                                  if (n == null || n <= 0) {
                                    return 'Enter positive number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 3,
                              child: DropdownButtonFormField<IntervalUnit>(
                                initialValue: _selectedIntervalUnit,
                                decoration: const InputDecoration(
                                  labelText: 'Interval Unit',
                                  border: OutlineInputBorder(),
                                ),
                                items: IntervalUnit.values
                                    .map(
                                      (i) => DropdownMenuItem(
                                        value: i,
                                        child: Text(i.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (v) {
                                  setState(() => _selectedIntervalUnit = v);
                                  _validateForm();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- COMPENSATIONS ---
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
                                          border: OutlineInputBorder(),
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
                                        onChanged: (v) {
                                          setState(() => comp.topic = v);
                                          _validateForm();
                                        },
                                        validator: (v) =>
                                            v == null ? 'Select topic' : null,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: comp.valueController,
                                        decoration: const InputDecoration(
                                          labelText: 'Value',
                                          border: OutlineInputBorder(),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (_) => _validateForm(),
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
                                        setState(
                                          () => _compensations.removeAt(index),
                                        );
                                        _validateForm();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }),
                            Align(
                              alignment: Alignment.center,
                              child: TextButton.icon(
                                onPressed: () => setState(
                                  () =>
                                      _compensations.add(_CompensationEntry()),
                                ),
                                icon: const Icon(Icons.add),
                                label: const Text('Add Compensation'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- TRANSACTION LABEL ---
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<TransactionLabel>(
                                initialValue: _selectedTransactionLabel,
                                decoration: const InputDecoration(
                                  labelText: 'Label',
                                  border: OutlineInputBorder(),
                                ),
                                hint: const Text('None'),
                                items: transactionLabelProvider
                                    .transactionLabels
                                    .map(
                                      (l) => DropdownMenuItem(
                                        value: l,
                                        child: Text(l.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(
                                      () => _selectedTransactionLabel = value,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Tooltip(
                              message: 'Manage Labels',
                              child: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ManageTransactionLabelsDialog(),
                                  );
                                  setState(
                                    () => _selectedTransactionLabel = null,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- VALUE ---
                        TextFormField(
                          controller: _valueController,
                          decoration: const InputDecoration(
                            labelText: 'Value',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _validateForm(),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Enter value';
                            if (num.tryParse(v) == null) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- DESCRIPTION ---
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            labelText: 'Description',
                          ),
                          maxLines: 2,
                        ),

                        const SizedBox(height: 16),

                        // --- ACTIONS ROW ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(width: 12),
                            ElevatedButton(
                              onPressed: _isFormValid
                                  ? () async {
                                      final Map<int, CompensationInfo>
                                      compensationsMap = {};
                                      for (
                                        int i = 0;
                                        i < _compensations.length;
                                        i++
                                      ) {
                                        final c = _compensations[i];
                                        final value = int.parse(
                                          c.valueController.text,
                                        );
                                        compensationsMap[i] = CompensationInfo(
                                          topicId: c.topic!.id,
                                          topicName: c.topic!.name,
                                          value: _isExpense ? -value : value,
                                        );
                                      }

                                      final intervalCount = int.parse(
                                        _intervalCountController.text,
                                      );
                                      final value = int.parse(
                                        _valueController.text,
                                      );

                                      await fixTransactionProvider
                                          .updateFixTransaction(
                                            widget.fixTransaction.id,
                                            _selectedTopic!.id,
                                            _status,
                                            _startDate!,
                                            _endDate!,
                                            intervalCount,
                                            _selectedIntervalUnit!,
                                            _isExpense ? -value : value,
                                            widget.fixTransaction.userRefId,
                                            _compensations.isEmpty
                                                ? null
                                                : compensationsMap,
                                            _selectedTransactionLabel?.id,
                                            _descriptionController.text.isEmpty
                                                ? null
                                                : _descriptionController.text,
                                            widget.fixTransaction.latestDate,
                                            widget.fixTransaction.varRefId,
                                            null,
                                          );

                                      Navigator.pop(context, true);
                                    }
                                  : null,
                              child: const Text('Save'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _CompensationEntry {
  Topic? topic;
  TextEditingController valueController = TextEditingController();

  _CompensationEntry();

  _CompensationEntry.withData(this.topic, String value) {
    valueController.text = value.toString();
  }
}
