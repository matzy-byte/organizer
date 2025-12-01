import 'package:flutter/material.dart';

class AppColors {
  static const primaryLight = Colors.blueAccent;
  static const primaryDark = Color(0xFF90CAF9);

  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: primaryLight,
    brightness: Brightness.light,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: primaryDark,
    brightness: Brightness.dark,
  );
}
