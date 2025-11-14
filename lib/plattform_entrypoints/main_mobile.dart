import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/themes/app_theme.dart';
import 'package:organizer/core/services/category_service.dart';
import 'package:organizer/core/services/fix_transaction_service.dart';
import 'package:organizer/core/services/topic_service.dart';
import 'package:organizer/core/services/var_transaction_service.dart';
import 'package:organizer/data/providers/drift_provider.dart';
import 'package:organizer/data/repositories/category_repository.dart';
import 'package:organizer/data/repositories/fix_transaction_repository.dart';
import 'package:organizer/data/repositories/topic_repository.dart';
import 'package:organizer/data/repositories/var_transaction_repository.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';

Future<void> runMobile() async {
  final db = await DriftProvider.instance;

  final categoryService = CategoryService(CategoryRepositoryDrift(db));
  final topicService = TopicService(TopicRepositoryDrift(db));
  final fixTransactionService = FixTransactionService(
    FixTransactionRepositoryDrift(db),
  );
  final varTransactionService = VarTransactionService(VarTransactionRepositoryDrift(db));

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
      theme: AppTheme.light,
      initialRoute: AppRoutes.dashboard,
      routes: AppRoutes.routes,
    );
  }
}
