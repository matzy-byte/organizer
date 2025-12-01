import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtil {
  static Color colorFromHexCode(String hexCode) =>
      Color(int.parse(hexCode.substring(1), radix: 16) + 0xFF000000);

  static Color randomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}
