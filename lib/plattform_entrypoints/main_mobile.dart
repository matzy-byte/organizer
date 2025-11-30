import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/themes/app_theme.dart';
import 'package:organizer/core/services/category_service.dart';
import 'package:organizer/core/services/file_service.dart';
import 'package:organizer/core/services/fix_transaction_service.dart';
import 'package:organizer/core/services/topic_service.dart';
import 'package:organizer/core/services/transaction_label_service.dart';
import 'package:organizer/core/services/user_service.dart';
import 'package:organizer/core/services/var_transaction_service.dart';
import 'package:organizer/core/utils/date_util.dart';
import 'package:organizer/data/providers/drift_provider.dart';
import 'package:organizer/data/repositories/category_repository.dart';
import 'package:organizer/data/repositories/file_repository.dart';
import 'package:organizer/data/repositories/fix_transaction_repository.dart';
import 'package:organizer/data/repositories/topic_repository.dart';
import 'package:organizer/data/repositories/transaction_label_repository.dart';
import 'package:organizer/data/repositories/user_repository.dart';
import 'package:organizer/data/repositories/var_transaction_repository.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/file_provider.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> runMobile() async {
  final db = await DriftProvider.instance;

  final categoryService = CategoryService(CategoryRepositoryDrift(db));
  final topicService = TopicService(TopicRepositoryDrift(db));
  final varTransactionRepository = VarTransactionRepositoryDrift(db);
  final fixTransactionService = FixTransactionService(
    FixTransactionRepositoryDrift(db),
    varTransactionRepository,
  );
  final varTransactionService = VarTransactionService(varTransactionRepository);
  final transactionLabelService = TransactionLabelService(
    TransactionLabellRepositoryDrift(db),
  );
  final userService = UserService(UserRepositoryDrift(db));
  final fileService = FileService(FileRepositoryDrift(db));

  await fixTransactionService.runDueFixTransactions();

  final prefs = await SharedPreferences.getInstance();
  globals.locale.value = Locale(prefs.getString('locale') ?? 'en');
  globals.from = DateUtil.getFromCurrentMonth();
  globals.to = DateUtil.getToCurrentMonth();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransactionLabelProvider(
            transactionLabelService: transactionLabelService,
          )..loadAllTransactionLabels(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(userService: userService)..loadAllUsers(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              CategoryProvider(categoryService: categoryService)
                ..loadCategories(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              TopicProvider(topicService: topicService)..loadAllTopics(),
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
        ),

        ChangeNotifierProvider(
          create: (_) => FileProvider(fileService: fileService),
        ),
      ],
      child: MobileApp(isSetup: (await userService.getAllUsers()).isEmpty),
    ),
  );
}

class MobileApp extends StatelessWidget {
  final bool isSetup;
  const MobileApp({super.key, required this.isSetup});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: globals.locale,
      builder: (context, locale, _) {
        return MaterialApp(
          title: 'Organizer',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          initialRoute: isSetup ? AppRoutes.setup : AppRoutes.start,
          routes: AppRoutes.routes,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        );
      },
    );
  }
}
