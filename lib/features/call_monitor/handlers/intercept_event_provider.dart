import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intercept_event_provider.g.dart';

class InterceptEvent {
  final String phoneNumber;
  final String actionName; 

  InterceptEvent({required this.phoneNumber, required this.actionName});
}

@Riverpod(keepAlive: true)
StreamController<InterceptEvent> interceptEventStreamController(Ref ref) {
  final controller = StreamController<InterceptEvent>.broadcast();
  ref.onDispose(controller.close);
  return controller;
}
