import 'package:flutter/services.dart';

abstract class BaseCallHandler {
  dynamic handleMethodCall(MethodCall call);
  Future<void> initialize() async {}
  Future<void> dispose() async {}
}

class CallHandlerFactory {
  final Map<String, BaseCallHandler> _handlers = {};

  void registerHandler(String key, BaseCallHandler handler) {
    _handlers[key] = handler;
  }

  BaseCallHandler? getHandler(String key) {
    return _handlers[key];
  }

  Future<void> initializeAll() async {
    for (final handler in _handlers.values) {
      await handler.initialize();
    }
  }

  Future<void> disposeAll() async {
    for (final handler in _handlers.values) {
      await handler.dispose();
    }
    _handlers.clear();
  }
}
