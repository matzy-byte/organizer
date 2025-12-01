// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
import 'package:organizer/l10n/app_localizations.dart';
import 'package:organizer/presentation/state/category_provider.dart';
import 'package:organizer/presentation/state/fix_transaction_provider.dart';
import 'package:organizer/presentation/state/synchronization_provider_desktop.dart';
import 'package:organizer/presentation/state/synchronization_provider_mobile.dart';
import 'package:organizer/presentation/state/topic_provider.dart';
import 'package:organizer/presentation/state/transaction_label_provider.dart';
import 'package:organizer/presentation/state/user_provider.dart';
import 'package:organizer/presentation/state/var_transaction_provider.dart';
import 'package:provider/provider.dart';

class SynchronizeExchange extends StatelessWidget {
  final bool isDesktop;
  final VoidCallback onCancel;
  final VoidCallback? onStart;

  const SynchronizeExchange({
    super.key,
    required this.isDesktop,
    required this.onCancel,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final at = AppLocalizations.of(context)!;
    final progress = isDesktop
        ? context.watch<SynchronizationProviderDesktop>().syncProgress
        : context.watch<SynchronizationProviderMobile>().syncProgress;

    final isSyncRunning = isDesktop
        ? context.watch<SynchronizationProviderDesktop>().isSyncRunning
        : context.watch<SynchronizationProviderMobile>().isSyncRunning;

    return AlertDialog(
      title: Text(at.synchronization),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDesktop) ...[
            if (!isSyncRunning && progress < 1.0)
              Text(at.mobileConnectedReadyToSynchronize)
            else if (progress < 1.0) ...[
              Text(at.synchronizing),
              SizedBox(height: 10),
              LinearProgressIndicator(value: progress),
            ] else
              Text(
                at.synchronizationComplete,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ] else ...[
            if (progress < 1.0) ...[
              Text(at.waitingForDesktop),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: progress),
            ] else
              Text(
                at.synchronizationComplete,
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ],
      ),
      actions: [
        progress >= 1.0
            ? TextButton(
                onPressed: () async {
                  if (isDesktop) {
                    await context.read<SynchronizationProviderDesktop>().stopServer();
                  } else {
                    await context.read<SynchronizationProviderMobile>().disconnect();
                  }
                  await context.read<UserProvider>().loadAllUsers();
                  await context
                      .read<TransactionLabelProvider>()
                      .loadAllTransactionLabels();
                  await context.read<CategoryProvider>().loadCategories();
                  await context.read<TopicProvider>().loadAllTopics();
                  await context.read<FixTransactionProvider>().reload();
                  await context.read<VarTransactionProvider>().reload();

                  Navigator.of(context).pop();
                  if (isDesktop) {
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(AppRoutes.start);
                    Navigator.of(context).pushNamed(AppRoutes.start);
                  } else {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.start);
                    Navigator.of(context).pushNamed(AppRoutes.start);
                  }
                },
                child: Text(at.okay),
              )
            : TextButton(onPressed: onCancel, child: Text(at.cancel)),
        if (isDesktop && onStart != null && !isSyncRunning && progress < 1.0)
          ElevatedButton(onPressed: onStart, child: Text(at.start)),
      ],
    );
  }
}
