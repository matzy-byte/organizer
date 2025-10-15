import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/theme.dart';
import 'package:organizer/core/services/category_service.dart';
import 'package:organizer/core/services/fix_transaction_service.dart';
import 'package:organizer/core/services/topic_service.dart';
import 'package:organizer/core/services/var_transaction_service.dart';
import 'package:organizer/data/repositories/category_repository_isar.dart';
import 'package:organizer/data/repositories/fix_transaction_repository_isar.dart';
import 'package:organizer/data/repositories/topic_repository_isar.dart';
import 'package:organizer/data/repositories/var_transaction_repository_isar.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';

void runMobile() {
  final categoryService = CategoryService(CategoryRepositoryIsar());
  final topicService = TopicService(TopicRepositoryIsar());
  final fixTransactionService = FixTransactionService(
    FixTransactionRepositoryIsar(),
  );
  final varTransactionService = VarTransactionService(VarTransactionRepositoryIsar());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              CategoryProvider(categoryService: categoryService)..loadCategories(),
        ),
        ChangeNotifierProvider(
          create: (_) => TopicProvider(topicService: topicService)..loadAllTopics(),
        ),
        ChangeNotifierProvider(
          create: (_) => FixTransactionProvider(
            fixTransactionService: fixTransactionService,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => VarTransactionProvider(
            varTransactionService: varTransactionService,
          ),
        )
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
      initialRoute: AppRoutes.dashboard,
      routes: AppRoutes.routes,
    );
  }
}
