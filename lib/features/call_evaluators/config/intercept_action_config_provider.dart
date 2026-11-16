import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';

final interceptActionConfigProvider = NotifierProvider<InterceptActionConfigNotifier, InterceptAction>(
  InterceptActionConfigNotifier.new,
);

class InterceptActionConfigNotifier extends Notifier<InterceptAction> {
  static const String _interceptActionKey = 'config_intercept_action';
  static const List<InterceptAction> availableValues = [
    InterceptAction.endCall,
    InterceptAction.answerThenHangup,
    InterceptAction.silenceNoAnswer,
  ];

  @override
  InterceptAction build() {
    _loadInterceptAction();
    return InterceptAction.endCall;
  }

  Future<void> _loadInterceptAction() async {
    final repository = ref.read(configRepositoryProvider);
    final config = await repository.getConfig(_interceptActionKey);
    debugPrint('InterceptAction config: $config');
    if (ref.mounted) {
      final actionString = config?['value'] as String? ?? 'endCall';
      state = availableValues.firstWhere(
        (e) => e.actionName == actionString,
        orElse: () => InterceptAction.endCall,
      );
    }
  }

  Future<void> setInterceptAction(InterceptAction newValue) async {
    await ref.read(configRepositoryProvider).saveConfig(
      _interceptActionKey,
      {'value': newValue.actionName},
    );

    if (ref.mounted) {
      state = newValue;
    }
  }
}

