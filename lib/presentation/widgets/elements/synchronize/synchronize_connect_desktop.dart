import 'package:flutter/material.dart';
import 'package:organizer/core/models/synchronization_configuration.dart';
import 'package:organizer/presentation/state/synchronization_provider_desktop.dart';
import 'package:organizer/presentation/widgets/elements/synchronize/synchronize_exchange.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SynchronizeConnectDesktop extends StatefulWidget {
  const SynchronizeConnectDesktop({super.key});

  @override
  State<SynchronizeConnectDesktop> createState() =>
      _SynchronizeConnectDesktopState();
}

class _SynchronizeConnectDesktopState extends State<SynchronizeConnectDesktop> {
  bool _desktopToMobile = true;
  bool _deleteMissing = false;
  bool _started = false;
  bool _shownDialog = false;
  BuildContext? _dialogContext;

  void _startServer() async {
    final provider = context.read<SynchronizationProviderDesktop>();
    final config = SynchronizationConfiguration(
      _desktopToMobile,
      _deleteMissing,
    );

    await provider.startServer(config);
    setState(() => _started = true);
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SynchronizationProviderDesktop>();

    // Configuration state
    if (!_started) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _directionRow(),
            _deleteMissingCheckbox(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startServer,
              child: const Text("Finish setup and start waiting for client"),
            ),
          ],
        ),
      );
    }

    // QR code / waiting for client
    final qrData = provider.qrData;
    if (qrData == null) return const Center(child: CircularProgressIndicator());

    // Show dialog when client connects
    if (provider.isClientConnected && !_shownDialog) {
      setState(() => _shownDialog = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            _dialogContext = ctx;
            return SynchronizeExchange(
              isDesktop: true,
              onCancel: () {
                _closeDialog();
                provider.stopServer();
                setState(() {
                  _shownDialog = false;
                  _started = false;
                });
              },
              onStart: () => provider.startSynchronization(),
            );
          },
        );
      });
    }

    if (!provider.isClientConnected && _shownDialog && _dialogContext != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _closeDialog();
        setState(() => _shownDialog = false);
      });
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Open Synchronization On Mobile",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          QrImageView(data: qrData, size: 250),
          const SizedBox(height: 20),
          if (!provider.isClientConnected)
            const Text("Client not connected yet…")
          else
            const Text("Client connected. Ready to sync!"),
        ],
      ),
    );
  }

  Widget _directionRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Desktop", style: TextStyle(fontSize: 18)),
        IconButton(
          onPressed: () => setState(() => _desktopToMobile = !_desktopToMobile),
          icon: AnimatedRotation(
            turns: _desktopToMobile ? 0 : 0.5,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.arrow_forward, size: 30),
          ),
        ),
        const Text("Mobile", style: TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _deleteMissingCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: _deleteMissing,
          onChanged: (v) => setState(() => _deleteMissing = v ?? false),
        ),
        const SizedBox(width: 8),
        const Text("Delete missing entries?", style: TextStyle(fontSize: 16)),
      ],
    );
  }

  void _closeDialog() {
    if (_dialogContext != null) {
      Navigator.of(_dialogContext!).pop();
      _dialogContext = null;
    }
  }
}
