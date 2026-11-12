import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_coordinator.g.dart';

/// 鍏ㄥ眬 App 涓灑鍗忚皟鍣?(App Coordinator / Event Mediator)
/// 璐熻矗璺?Feature 閫氫俊涓庤В鑰︿簨浠舵淳鍙戯紝褰诲簳娑堥櫎 lib/features/X 璺ㄥ寘寮曠敤 lib/features/Y
@Riverpod(keepAlive: true)
AppCoordinator appCoordinator(Ref ref) {
  return AppCoordinator(ref);
}

class AppCoordinator {
  final Ref ref;
  final StreamController<Map<String, dynamic>> _eventBus = StreamController.broadcast();

  AppCoordinator(this.ref);

  /// 骞挎挱璺ㄦā鍧椾簨浠?
  void emit(String eventName, [Map<String, dynamic>? payload]) {
    debugPrint('[AppCoordinator] Event emitted: $eventName, payload: $payload');
    _eventBus.add({
      'event': eventName,
      'payload': payload ?? {},
    });
  }

  /// 鐩戝惉鎸囧畾璺ㄦā鍧椾簨浠?
  StreamSubscription<Map<String, dynamic>> on(String eventName, void Function(Map<String, dynamic> payload) callback) {
    return _eventBus.stream.where((event) => event['event'] == eventName).listen((event) {
      callback(event['payload'] as Map<String, dynamic>);
    });
  }
}
