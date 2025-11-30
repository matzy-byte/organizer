import 'dart:io';
import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/core/services/category_service.dart';
import 'package:organizer/core/services/file_service.dart';
import 'package:organizer/core/services/fix_transaction_service.dart';
import 'package:organizer/core/services/synchronization_service_desktop.dart';
import 'package:organizer/core/services/synchronization_service_mobile.dart';
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
import 'package:organizer/plattform_entrypoints/main_desktop.dart';
import 'package:organizer/plattform_entrypoints/mobile_app.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/file_provider.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/synchronization_provider_desktop.dart';
import 'package:organizer/presentation/state/synchronization_provider_mobile.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef IntCallback = void Function(int value);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await run();
}

Future<void> run() async {
  final isDesktop = Platform.isWindows || Platform.isLinux || Platform.isMacOS;
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
  final synchronizationServiceDesktop = SynchronizationServiceDesktop(db);
  final synchronizationServiceMobile = SynchronizationServiceMobile(db);

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
        ChangeNotifierProvider(
          create: (_) => SynchronizationProviderDesktop(synchronizationServiceDesktop),
        ),
        ChangeNotifierProvider(
          create: (_) => SynchronizationProviderMobile(synchronizationServiceMobile),
        ),
      ],
      child: isDesktop
          ? DesktopApp(isSetup: (await userService.getAllUsers()).isEmpty)
          : MobileApp(isSetup: (await userService.getAllUsers()).isEmpty),
    ),
  );
}
