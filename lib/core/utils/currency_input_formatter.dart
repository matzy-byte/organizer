import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final String locale;
  final String? currencyCode;

  CurrencyInputFormatter({required this.locale, this.currencyCode});

  static String formatValue({
    required int value,
    required String locale,
    String? currencyCode,
  }) {
    double realValue = value / 100;

    final symbol = currencyCode == null
        ? NumberFormat.simpleCurrency(locale: locale).currencySymbol
        : NumberFormat.simpleCurrency(name: currencyCode).currencySymbol;

    final formatter = NumberFormat.currency(locale: locale, symbol: symbol);
    return formatter.format(realValue);
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) digits = '0';
    double value = double.parse(digits) / 100;
    final symbol = currencyCode == null
        ? NumberFormat.simpleCurrency(locale: locale).currencySymbol
        : NumberFormat.simpleCurrency(name: currencyCode).currencySymbol;

    final formatter = NumberFormat.currency(locale: locale, symbol: symbol);

    String formatted = formatter.format(value);
    final symbolIndex = formatted.lastIndexOf(symbol);
    int cursorPosition = formatted.length;
    final isPrefix = symbolIndex == 0;

    if (isPrefix) {
      cursorPosition = (formatted.indexOf(RegExp(r'\d')));
      final lastDigit = RegExp(r'\d(?=\D*$)').firstMatch(formatted);
      if (lastDigit != null) cursorPosition = lastDigit.end;
    } else {
      final lastDigit = RegExp(r'\d(?=\D*$)').firstMatch(formatted);
      cursorPosition = lastDigit?.end ?? formatted.length;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
