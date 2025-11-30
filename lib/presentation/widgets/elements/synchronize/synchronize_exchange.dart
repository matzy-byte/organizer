import 'package:flutter/material.dart';
import 'package:organizer/app/routes.dart';
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
    final progress = isDesktop
        ? context.watch<SynchronizationProviderDesktop>().syncProgress
        : context.watch<SynchronizationProviderMobile>().syncProgress;

    final isSyncRunning = isDesktop
        ? context.watch<SynchronizationProviderDesktop>().isSyncRunning
        : context.watch<SynchronizationProviderMobile>().isSyncRunning;

    return AlertDialog(
      title: const Text("Synchronization"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDesktop) ...[
            if (!isSyncRunning && progress < 1.0)
              const Text("Phone connected. Ready to synchronize?")
            else if (progress < 1.0) ...[
              const Text("Synchronizing…"),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: progress),
            ] else
              const Text(
                "Synchronization complete!",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ] else ...[
            if (progress < 1.0) ...[
              const Text("Waiting for desktop…"),
              const SizedBox(height: 10),
              LinearProgressIndicator(value: progress),
            ] else
              const Text(
                "Synchronization complete!",
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
                onPressed: () {
                  if (isDesktop) {
                    context.read<SynchronizationProviderDesktop>().stopServer();
                  } else {
                    context.read<SynchronizationProviderMobile>().disconnect();
                  }
                  context.read<UserProvider>().loadAllUsers();
                  context.read<TransactionLabelProvider>().loadAllTransactionLabels();
                  context.read<CategoryProvider>().loadCategories();
                  context.read<TopicProvider>().loadAllTopics();
                  context.read<FixTransactionProvider>().reload();
                  context.read<VarTransactionProvider>().reload();

                  Navigator.of(context).pop();
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRoutes.dashboard);
                },
                child: const Text("Ok"),
              )
            : TextButton(onPressed: onCancel, child: const Text("Cancel")),
        if (isDesktop && onStart != null && !isSyncRunning && progress < 1.0)
          ElevatedButton(onPressed: onStart, child: const Text("Start")),
      ],
    );
  }
}
