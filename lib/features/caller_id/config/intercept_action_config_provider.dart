import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/data/repositories/config/config_repository.dart';
import 'package:yourcallyourrule/features/caller_id/config/caller_id_config_repository.dart';

final interceptActionConfigProvider = StateNotifierProvider<InterceptActionConfigNotifier, String>((ref) {
  final configRepository = SharedPreferencesConfigRepository();
  return InterceptActionConfigNotifier(configRepository);
});

class InterceptActionConfigNotifier extends StateNotifier<String> {
  final ConfigRepository _configRepository;

  InterceptActionConfigNotifier(this._configRepository) : super('endCall') {
    _loadInterceptAction();
  }

  static const String _interceptActionKey = 'config_intercept_action';

  Future<void> _loadInterceptAction() async {
    final config = await _configRepository.getConfig(_interceptActionKey);
    state = config?['value'] as String? ?? 'endCall';
  }

  Future<void> setInterceptAction(String? newValue) async {
    await _configRepository.saveConfig(_interceptActionKey, {'value': newValue!});
    state = newValue;
  }
}