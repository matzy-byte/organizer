import 'package:flutter/material.dart';
import 'package:organizer/presentation/screens/dashboard/dashboard.dart';

class AppRoutes {
  static String dashboard = "/";
  static Map<String, WidgetBuilder> routes = {
    dashboard: (context) => const Dashboard(),
  };
}
