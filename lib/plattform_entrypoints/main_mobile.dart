import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/theme.dart';
import 'package:organizer/core/services/category_service.dart';
import 'package:organizer/core/services/topic_service.dart';
import 'package:organizer/data/repositories/category_repository_isar.dart';
import 'package:organizer/data/repositories/topic_repository_isar.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:provider/provider.dart';

void runMobile() {
  final categoryService = CategoryService(CategoryRepositoryIsar());
  final topicService = TopicService(TopicRepositoryIsar());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(service: categoryService)..loadCategories(),
        ),
        ChangeNotifierProvider(
          create: (_) => TopicProvider(topicService: topicService),
        ),
      ],
      child: const MobileApp(),
    ),
  );
}

class MobileApp extends StatelessWidget {
  const MobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Organizer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.settings,
      routes: AppRoutes.routes,
    );
  }
}
