import 'package:flutter/material.dart';

class OptionsElement extends StatefulWidget {
  const OptionsElement({super.key});

  @override
  State<StatefulWidget> createState() => _OptionElement();
}

class _OptionElement extends State<OptionsElement> {
  DateTime _selectedFromDate = DateTime.now().subtract(
    const Duration(days: 30),
  );
  DateTime _selectedToDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime now = DateTime.now();
    final DateTime initialDate = isFromDate
        ? _selectedFromDate
        : _selectedToDate;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year - 99),
      lastDate: DateTime(now.year + 99),
    );

    if (picked != null && picked != initialDate) {
      setState(() {
        if (isFromDate) {
          _selectedFromDate = picked;
        } else {
          _selectedToDate = picked;
        }
        if (_selectedFromDate.isAfter(_selectedToDate)) {
          if (isFromDate) {
            _selectedToDate = _selectedFromDate;
          } else {
            _selectedFromDate = _selectedToDate;
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          const Text('Options'),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text('From'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_selectedFromDate.toString()),
                        IconButton(
                          onPressed: () => _selectDate(context, true),
                          icon: Icon(Icons.calendar_today),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text('To'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_selectedToDate.toString()),
                        IconButton(
                          onPressed: () => _selectDate(context, false),
                          icon: Icon(Icons.calendar_today),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
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
    );
  }
}
