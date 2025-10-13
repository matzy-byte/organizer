import 'package:flutter/material.dart';
import 'package:organizer/presentation/screens/category_screen.dart';
import 'package:organizer/presentation/screens/dashboard_screen.dart';
import 'package:organizer/presentation/screens/settings_screen.dart';
import 'package:organizer/presentation/screens/topic_screen.dart';

class AppRoutes {
  static String dashboard = "/";
  static String settings = "/settings";
  static String category = "/category";
  static String topic = "/topic";
  static Map<String, WidgetBuilder> routes = {
    dashboard: (context) => const DashboardScreen(),
    settings: (context) => const SettingsScreen(),
    category: (context) => const CategoryScreen(),
    topic: (context) => const TopicScreen(),
  };
}
