import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:organizer/core/services/synchronization_service_mobile.dart';

class SynchronizationProviderMobile with ChangeNotifier {
  final SynchronizationServiceMobile service;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  double _syncProgress = 0.0;
  double get syncProgress => _syncProgress;
  bool get isSyncRunning => _syncProgress > 0 && _syncProgress < 1.0;

  String? _lastMessage;
  String? get lastMessage => _lastMessage;

  SynchronizationProviderMobile(this.service) {
    service.onMessage = _handleServiceMessage;
  }

  Future<void> connect(String ip, int port, String key) async {
    await service.connect(ip, port, key);
    _isConnected = service.isConnected;
    notifyListeners();
  }

  Future<void> disconnect() async {
    await service.disconnect();
    _isConnected = false;
    _syncProgress = 0.0;
    notifyListeners();
  }

  void sendMessage(Map<String, dynamic> data) {
    service.send(jsonEncode(data));
  }

  void _handleServiceMessage(Map<String, dynamic> msg) {
    _lastMessage = msg.toString();

    switch (msg['type']) {
      case 'sync_start':
        _syncProgress = 0.001;
        break;
      case 'table_data':
        final tableIndex = msg['tableIndex'] as int;
        final tableCount = msg['tableCount'] as int? ?? 1;
        _syncProgress = (tableIndex + 1) / tableCount;
        break;
      case 'sync_complete':
        _syncProgress = 1.0;
        break;
      case 'disconnect':
        _isConnected = false;
    }

    notifyListeners();
  }
}
