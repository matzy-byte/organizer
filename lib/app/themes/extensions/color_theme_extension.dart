import 'package:flutter/material.dart';

class ColorTheme extends ThemeExtension<ColorTheme> {
  final Color valuePositive;
  final Color valueNegative;
  final Color valueNeutral;

  const ColorTheme({
    required this.valuePositive,
    required this.valueNegative,
    required this.valueNeutral,
  });

  @override
  ColorTheme copyWith({
    Color? valuePositive,
    Color? valueNegative,
    Color? valueNeutral,
  }) {
    return ColorTheme(
      valuePositive: valuePositive ?? this.valuePositive,
      valueNegative: valueNegative ?? this.valueNegative,
      valueNeutral: valueNeutral ?? this.valueNeutral,
    );
  }

  @override
  ColorTheme lerp(ThemeExtension<ColorTheme>? other, double t) {
    if (other is! ColorTheme) return this;
    return ColorTheme(
      valuePositive: Color.lerp(valuePositive, other.valuePositive, t)!,
      valueNegative: Color.lerp(valueNegative, other.valueNegative, t)!,
      valueNeutral: Color.lerp(valueNeutral, other.valueNeutral, t)!,
    );
  }
}
