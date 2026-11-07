import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/call_policy/evaluators/intercept_action.dart';

final configRepositoryProvider = Provider<ConfigRepository>((ref) {
  return SharedPreferencesConfigRepository();
});

final interceptActionConfigProvider = NotifierProvider<InterceptActionConfigNotifier, InterceptAction>(
  InterceptActionConfigNotifier.new,
);

class InterceptActionConfigNotifier extends Notifier<InterceptAction> {
  static const String _interceptActionKey = 'config_intercept_action';

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
      state = InterceptAction.values.firstWhere(
        (e) => e.name == actionString,
        orElse: () => InterceptAction.endCall,
      );
    }
  }

  Future<void> setInterceptAction(InterceptAction newValue) async {
    await ref.read(configRepositoryProvider).saveConfig(
      _interceptActionKey,
      {'value': newValue.name},
    );

    if (ref.mounted) {
      state = newValue;
    }
  }
}
