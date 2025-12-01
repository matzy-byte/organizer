import 'package:flutter/material.dart';
import 'package:organizer/app/globals.dart' as globals;
import 'package:organizer/app/routes.dart';
import 'package:organizer/app/themes/app_theme.dart';
import 'package:organizer/l10n/app_localizations.dart';

class DesktopApp extends StatelessWidget {
  final bool isSetup;
  const DesktopApp({super.key, required this.isSetup});

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
