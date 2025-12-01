import 'package:flutter/material.dart';

class AppTextStyles {
  static const _fontFamily = 'Roboto';

  // ---------------- LIGHT THEME ----------------
  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
  ).apply(fontFamily: _fontFamily);

  // ---------------- DARK THEME ----------------
  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: const TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    titleLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: const TextStyle(fontSize: 16, color: Colors.white),
    bodyMedium: const TextStyle(fontSize: 14, color: Colors.white70),
    labelLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ).apply(fontFamily: _fontFamily);
}
