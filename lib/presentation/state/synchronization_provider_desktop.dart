import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:organizer/core/models/synchronization_configuration.dart';
import 'package:organizer/core/services/synchronization_service_desktop.dart';

class SynchronizationProviderDesktop with ChangeNotifier {
  final SynchronizationServiceDesktop service;

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  bool _isClientConnected = false;
  bool get isClientConnected => _isClientConnected;

  double _syncProgress = 0.0;
  double get syncProgress => _syncProgress;
  bool get isSyncRunning => _syncProgress > 0 && _syncProgress < 1.0;

  String? _lastMessage;
  String? get lastMessage => _lastMessage;

  String? get qrData => service.qrData;

  SynchronizationProviderDesktop(this.service) {
    service.onMessage = _handleServiceMessage;
  }

  /// Start server with configuration
  Future<void> startServer(SynchronizationConfiguration config) async {
    await service.startServer(config);
    _isRunning = service.isRunning;
    notifyListeners();
  }

  /// Stop server
  Future<void> stopServer() async {
    await service.stopServer();
    _isRunning = false;
    _isClientConnected = false;
    _syncProgress = 0.0;
    notifyListeners();
  }

  /// Send message to client
  void sendMessage(Map<String, dynamic> data) {
    service.send(jsonEncode(data));
  }

  Future<void> startSynchronization() async {
    await service.startSynchronization();
  }

  /// Handle messages from service
  void _handleServiceMessage(Map<String, dynamic> msg) {
    _lastMessage = msg.toString();

    switch (msg['type']) {
      case 'client_connected':
        _isClientConnected = true;
        _syncProgress = 0.0;
        break;
      case 'client_disconnected':
        _isClientConnected = false;
        _syncProgress = 0.0;
        break;
      case 'table_data':
        final tableIndex = msg['tableIndex'] as int;
        final tableCount = msg['tableCount'] as int? ?? 1;
        _syncProgress = (tableIndex + 1) / tableCount;
        break;
      case 'sync_complete':
        _syncProgress = 1.0;
        break;
    }

    notifyListeners();
  }
}
