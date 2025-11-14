import 'dart:ui';
import 'package:flutter/material.dart';

class SetupTheme extends ThemeExtension<SetupTheme> {
  final double sectionSpacing;
  final double itemSpacing;
  final double cardMaxWidth;
  final EdgeInsets cardPadding;

  const SetupTheme({
    required this.sectionSpacing,
    required this.itemSpacing,
    required this.cardMaxWidth,
    required this.cardPadding,
  });

  @override
  SetupTheme copyWith({
    double? sectionSpacing,
    double? itemSpacing,
    double? cardMaxWidth,
    EdgeInsets? cardPadding,
  }) {
    return SetupTheme(
      sectionSpacing: sectionSpacing ?? this.sectionSpacing,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      cardMaxWidth: cardMaxWidth ?? this.cardMaxWidth,
      cardPadding: cardPadding ?? this.cardPadding,
    );
  }

  @override
  SetupTheme lerp(ThemeExtension<SetupTheme>? other, double t) {
    if (other is! SetupTheme) return this;
    return SetupTheme(
      sectionSpacing: lerpDouble(sectionSpacing, other.sectionSpacing, t)!,
      itemSpacing: lerpDouble(itemSpacing, other.itemSpacing, t)!,
      cardMaxWidth: lerpDouble(cardMaxWidth, other.cardMaxWidth, t)!,
      cardPadding: EdgeInsets.lerp(cardPadding, other.cardPadding, t)!,
    );
  }
}
