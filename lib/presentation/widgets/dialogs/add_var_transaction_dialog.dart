import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/app/themes/extensions/setup_theme_extension.dart';
import 'package:organizer/core/models/category.dart';
import 'package:organizer/core/models/compensation_info.dart';
import 'package:organizer/core/models/topic.dart';
import 'package:organizer/core/models/transaction_label.dart';
import 'package:organizer/core/utils/currency_formatter.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:organizer/presentation/widgets/dialogs/manage_transaction_labels_dialog.dart';
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

  TransactionLabel? _selectedTransactionLabel;

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

    WidgetsBinding.instance.addPostFrameCallback((_) => _validateForm());
  }

  @override
  void dispose() {
    _valueController.dispose();
    _descriptionController.dispose();
    for (var comp in _compensations) {
      comp.valueController.dispose();
    }
    super.dispose();
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (_isFormValid != isValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 99),
      lastDate: DateTime(now.year + 99),
    );
    if (picked != null) {
      setState(() => _date = picked);
      _validateForm();
    }
  }

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final setupTheme = theme.extension<SetupTheme>()!;
    final transactionLabelProvider = context.read<TransactionLabelProvider>();
    final topicProvider = context.read<TopicProvider>();
    final varTransactionProvider = context.read<VarTransactionProvider>();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: setupTheme.cardPadding,
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
                          '${at.add} ${at.transaction}',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- CATEGORY ---
                        DropdownButtonFormField<Category>(
                          initialValue: _selectedCategory,
                          decoration: InputDecoration(
                            labelText: at.category,
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
                          validator: (value) =>
                              value == null ? at.itemInvalid(at.category) : null,
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- TOPIC ---
                        if (_selectedCategory != null)
                          DropdownButtonFormField<Topic>(
                            initialValue: _selectedTopic,
                            decoration: InputDecoration(
                              labelText: at.topic,
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
                            onChanged: (value) {
                              setState(() => _selectedTopic = value);
                              _validateForm();
                            },
                            validator: (value) =>
                                value == null ? at.itemInvalid(at.topic) : null,
                          ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- SEGMENTED POSITIVE/NEGATIVE ---
                        SegmentedButton<bool>(
                          segments: [
                            ButtonSegment(value: true, label: Text(at.negative)),
                            ButtonSegment(
                              value: false,
                              label: Text(at.positive),
                            ),
                          ],
                          selected: <bool>{_isExpense},
                          onSelectionChanged: (newSelection) {
                            setState(() => _isExpense = newSelection.first);
                          },
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- DATE ---
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: at.date,
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: _date == null
                                ? ''
                                : '${_date!.toLocal()}'.split(' ')[0],
                          ),
                          onTap: () => _pickDate(context),
                          validator: (value) => (value == null || value.isEmpty)
                              ? at.itemInvalid(at.date)
                              : null,
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- COMPENSATIONS ---
                        ExpansionTile(
                          title: Text(at.compensations),
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
                                        decoration: InputDecoration(
                                          labelText: at.topic,
                                          border: OutlineInputBorder(),
                                        ),
                                        items: _allTopics
                                            .map(
                                              (t) => DropdownMenuItem(
                                                value: t,
                                                child: Text(
                                                  '${_categories.firstWhere((c) => c.id == t.categoryId).name}/${t.name}',
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() => comp.topic = value);
                                          _validateForm();
                                        },
                                        validator: (value) => value == null
                                            ? at.itemInvalid(at.topic)
                                            : null,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: comp.valueController,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: at.value,
                                          border: OutlineInputBorder(),
                                        ),
                                        inputFormatters: [
                                          CurrencyInputFormatter(),
                                        ],
                                        onChanged: (_) => _validateForm(),
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return at.itemInvalid(at.value);
                                          }
                                          if (num.tryParse(
                                                v.replaceAll(
                                                  RegExp(r'[^0-9]'),
                                                  '',
                                                ),
                                              ) ==
                                              null) {
                                            return at.itemInvalid(at.value);
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
                              alignment: Alignment.center,
                              child: TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _compensations.add(_CompensationEntry());
                                  });
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => _validateForm(),
                                  );
                                },
                                icon: const Icon(Icons.add),
                                label: Text('${at.add} ${at.compensation}'),
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
                                decoration: InputDecoration(
                                  labelText: at.label,
                                  border: OutlineInputBorder(),
                                ),
                                hint: Text(at.none),
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
                              message: '${at.manage} ${at.labels}',
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
                          decoration: InputDecoration(
                            labelText: at.value,
                            border: OutlineInputBorder(),
                          ),
                          inputFormatters: [CurrencyInputFormatter()],
                          keyboardType: TextInputType.number,
                          onChanged: (_) => _validateForm(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return at.itemInvalid(at.value);
                            }
                            if (num.tryParse(
                                  value.replaceAll(RegExp(r'[^0-9]'), ''),
                                ) ==
                                null) {
                              return at.itemInvalid(at.value);
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- DESCRIPTION ---
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: at.description,
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: setupTheme.sectionSpacing),

                        // --- ACTIONS ---
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
                                  ? () async {
                                      final Map<int, CompensationInfo>
                                      compensationsMap = {};
                                      for (final c in _compensations) {
                                        final value = int.parse(
                                          c.valueController.text.replaceAll(
                                            RegExp(r'[^0-9]'),
                                            '',
                                          ),
                                        );
                                        final compId = await varTransactionProvider
                                            .addVarTransaction(
                                              c.topic!.id,
                                              _date!,
                                              _isExpense ? -1 * value : value,
                                              globals.user.id,
                                              null,
                                              _selectedTransactionLabel?.id,
                                              '${at.compensation}: ${_descriptionController.text}',
                                              null,
                                              null,
                                              null,
                                            );
                                        compensationsMap[compId] =
                                            CompensationInfo(
                                              topicId: c.topic!.id,
                                              topicName: c.topic!.name,
                                              value: _isExpense
                                                  ? -1 * value
                                                  : value,
                                            );
                                      }

                                      final value = int.parse(
                                        _valueController.text.replaceAll(
                                          RegExp(r'[^0-9]'),
                                          '',
                                        ),
                                      );
                                      final varTransactionId =
                                          await varTransactionProvider
                                              .addVarTransaction(
                                                _selectedTopic!.id,
                                                _date!,
                                                _isExpense ? -1 * value : value,
                                                globals.user.id,
                                                compensationsMap.isEmpty
                                                    ? null
                                                    : compensationsMap,
                                                _selectedTransactionLabel?.id,
                                                _descriptionController
                                                        .value
                                                        .text
                                                        .isEmpty
                                                    ? null
                                                    : _descriptionController
                                                          .value
                                                          .text,
                                                null,
                                                null,
                                                null,
                                              );

                                      for (final id in compensationsMap.keys) {
                                        await varTransactionProvider
                                            .setVarReference(
                                              id,
                                              varTransactionId,
                                            );
                                      }

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
      ),
    );
  }
}

class _CompensationEntry {
  Topic? topic;
  TextEditingController valueController = TextEditingController();
  _CompensationEntry();
}
