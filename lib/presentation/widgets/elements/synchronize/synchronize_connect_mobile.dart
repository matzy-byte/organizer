import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:organizer/presentation/state/synchronization_provider_mobile.dart';
import 'package:provider/provider.dart';
import 'synchronize_exchange.dart';

class SynchronizeConnectMobile extends StatefulWidget {
  const SynchronizeConnectMobile({super.key});

  @override
  State<SynchronizeConnectMobile> createState() =>
      _SynchronizeConnectMobileState();
}

class _SynchronizeConnectMobileState extends State<SynchronizeConnectMobile> {
  bool _shownDialog = false;
  BuildContext? _dialogContext;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SynchronizationProviderMobile>();

    // Show dialog when connected to desktop
    if (provider.isConnected && !_shownDialog) {
      _shownDialog = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            _dialogContext = ctx;
            return SynchronizeExchange(
              isDesktop: false,
              onCancel: () {
                _closeDialog();
                provider.disconnect();
                setState(() => _shownDialog = false);
              },
            );
          },
        );
      });
    }

    if (!provider.isConnected && _shownDialog && _dialogContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _closeDialog();
        setState(() => _shownDialog = false);
      });
    }

    return MobileScanner(
      onDetect: (capture) async {
        final raw = capture.barcodes.first.rawValue;
        if (raw == null) return;

        try {
          final data = jsonDecode(raw);
          await provider.connect(data['ip'], data['port'], data['key']);
        } catch (e) {
          // handle invalid QR code
          debugPrint('Invalid QR code: $e');
        }
      },
    );
  }

  void _closeDialog() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }
}
