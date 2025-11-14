import 'package:flutter/material.dart';

class OptionsElement extends StatefulWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final void Function(DateTime from, DateTime to) onFilterChanged;

  const OptionsElement({
    super.key,
    this.fromDate,
    this.toDate,
    required this.onFilterChanged,
  });

  @override
  State<OptionsElement> createState() => _OptionsElementState();
}

class _OptionsElementState extends State<OptionsElement> {
  late DateTime _selectedFromDate;
  late DateTime _selectedToDate;

  @override
  void initState() {
    super.initState();

    _selectedFromDate =
        widget.fromDate ?? DateTime.now().subtract(const Duration(days: 30));
    _selectedToDate = widget.toDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final now = DateTime.now();
    final initialDate = isFromDate ? _selectedFromDate : _selectedToDate;

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 99),
      lastDate: DateTime(now.year + 99),
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        if (isFromDate) {
          _selectedFromDate = picked;
          if (_selectedFromDate.isAfter(_selectedToDate)) {
            _selectedToDate = _selectedFromDate;
          }
        } else {
          _selectedToDate = picked;
          if (_selectedToDate.isBefore(_selectedFromDate)) {
            _selectedFromDate = _selectedToDate;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Text(
              'Options',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('From'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_selectedFromDate.toString().split(' ')[0]),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context, true),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('To'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(_selectedToDate.toString().split(' ')[0]),
                          IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectDate(context, false),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    widget.onFilterChanged(_selectedFromDate, _selectedToDate);
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
