import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/theme.dart';

void runMobile() {
  runApp(const MobileApp());
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Organizer",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.dashboard,
      routes: AppRoutes.routes,
    );
  }
}
