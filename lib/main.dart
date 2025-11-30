import 'dart:io';
import 'package:flutter/material.dart';
import 'package:organizer/plattform_entrypoints/main_desktop.dart';
import 'package:organizer/plattform_entrypoints/main_mobile.dart';

typedef IntCallback = void Function(int value);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await runDesktop();
  } else {
    await runMobile();
  }
}
