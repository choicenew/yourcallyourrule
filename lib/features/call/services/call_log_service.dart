import 'dart:async';

import 'package:yourcallyourrule/core/entities/call/call_log.dart';
import 'package:yourcallyourrule/core/repositories/call_log_repository.dart';

class CallLogService {
  final CallLogRepository _repository;
  final StreamController<List<CallLog>> _logController = StreamController.broadcast();

  CallLogService(this._repository);

  Stream<List<CallLog>> get logsStream => _logController.stream;

  Future<void> initialize() async {
    await _loadAllLogs();
    await _setupAutoRefresh();
  }

  Future<void> _loadAllLogs() async {
    try {
      final logs = await _repository.getRecentLogs();
      _logController.add(logs);
    } catch (e) {
      _logController.addError(e);
    }
  }

  Future<void> refresh() async {
    await _repository.refreshLogs();
    await _loadAllLogs();
  }

  Future<void> _setupAutoRefresh() async {
    _repository.watchLogs().listen((logs) {
      _logController.add(logs);
    });
  }

  Future<void> addLog(CallLog log) async {
    await _repository.addLog(log);
    await refresh();
  }
}