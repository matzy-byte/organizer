import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizer/app/themes/extensions/color_theme_extension.dart';

class CurrencyText extends StatelessWidget {
  final num value;
  final TextStyle? style;
  final String? currencyCode;
  final bool isCompensation;

  const CurrencyText({
    super.key,
    required this.value,
    this.style,
    this.currencyCode,
    this.isCompensation = false,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;

    final symbol = currencyCode == null
        ? NumberFormat.simpleCurrency(locale: locale).currencySymbol
        : NumberFormat.simpleCurrency(name: currencyCode).currencySymbol;

    final formatter = NumberFormat.currency(locale: locale, symbol: symbol);

    final formatted = formatter.format(value);
    final colorTheme = Theme.of(context).extension<ColorTheme>()!;

    Color color;
    if (value > 0) {
      color = colorTheme.valuePositive;
    } else if (value < 0) {
      color = colorTheme.valueNegative;
    } else {
      color = colorTheme.valueNeutral;
    }

    final textStyle = (style ?? Theme.of(context).textTheme.titleSmall!)
        .copyWith(color: color);

    return Text(
      isCompensation ? '($formatted)' : formatted,
      style: textStyle,
    );
  }
}
