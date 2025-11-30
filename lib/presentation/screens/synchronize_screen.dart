import 'dart:io';
import 'package:flutter/material.dart';
import 'package:organizer/presentation/state/synchronization_provider_desktop.dart';
import 'package:organizer/presentation/state/synchronization_provider_mobile.dart';
import 'package:organizer/presentation/widgets/elements/synchronize/synchronize_connect_desktop.dart';
import 'package:organizer/presentation/widgets/elements/synchronize/synchronize_connect_mobile.dart';
import 'package:provider/provider.dart';

class SynchronizeScreen extends StatelessWidget {
  const SynchronizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Synchronize'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
                context.read<SynchronizationProviderDesktop>().stopServer();
              } else {
                context.read<SynchronizationProviderMobile>().disconnect();
              }
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Platform.isWindows || Platform.isLinux || Platform.isMacOS
          ? const SynchronizeConnectDesktop()
          : const SynchronizeConnectMobile(),
    );
  }
}
