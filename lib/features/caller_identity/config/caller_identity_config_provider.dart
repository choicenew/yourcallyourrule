import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/caller_identity/config/caller_identity_config_repository.dart';
import 'package:yourcallyourrule/features/call_coordinator/handlers/display_mode.dart';

final callerIdConfigRepositoryProvider = Provider<CallerIdConfigRepository>((ref) {
  final configRepository = SharedPreferencesConfigRepository();
  return CallerIdConfigRepository(configRepository);
});

final callerIdConfigProvider = NotifierProvider<CallerIdConfigNotifier, CallerIdConfig>(
  CallerIdConfigNotifier.new,
);

class CallerIdConfig {
  final bool useLocalNotification;
  final bool cancelLocalNotification;
  final bool useStirNotification;
  final DisplayMode displayMode;
  final Duration notificationAutoCancelDelay;

  const CallerIdConfig({
    required this.useLocalNotification,
    required this.cancelLocalNotification,
    required this.useStirNotification,
    required this.displayMode,
    required this.notificationAutoCancelDelay,
  });

  CallerIdConfig copyWith({
    bool? useLocalNotification,
    bool? cancelLocalNotification,
    bool? useStirNotification,
    DisplayMode? displayMode,
    Duration? notificationAutoCancelDelay,
  }) {
    return CallerIdConfig(
      useLocalNotification: useLocalNotification ?? this.useLocalNotification,
      cancelLocalNotification: cancelLocalNotification ?? this.cancelLocalNotification,
      useStirNotification: useStirNotification ?? this.useStirNotification,
      displayMode: displayMode ?? this.displayMode,
      notificationAutoCancelDelay: notificationAutoCancelDelay ?? this.notificationAutoCancelDelay,
    );
  }

  factory CallerIdConfig.fromMap(Map<String, dynamic> map) {
    return CallerIdConfig(
      useLocalNotification: map[CallerIdConfigRepository.useLocalNotificationKey] as bool? ?? false,
      cancelLocalNotification: map[CallerIdConfigRepository.cancelLocalNotificationKey] as bool? ?? false,
      useStirNotification: map[CallerIdConfigRepository.useStirNotificationKey] as bool? ?? false,
      displayMode: DisplayMode.fromString(map[CallerIdConfigRepository.displayModeKey]),
      notificationAutoCancelDelay: Duration(seconds: map[CallerIdConfigRepository.notificationAutoCancelDelayKey] as int? ?? CallerIdConfigRepository.defaultNotificationAutoCancelDelayInSeconds),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      CallerIdConfigRepository.useLocalNotificationKey: useLocalNotification,
      CallerIdConfigRepository.cancelLocalNotificationKey: cancelLocalNotification,
      CallerIdConfigRepository.useStirNotificationKey: useStirNotification,
      CallerIdConfigRepository.displayModeKey: displayMode.name,
      CallerIdConfigRepository.notificationAutoCancelDelayKey: notificationAutoCancelDelay.inSeconds,
    };
  }
}

class CallerIdConfigNotifier extends Notifier<CallerIdConfig> {
  @override
  CallerIdConfig build() {
    _loadConfig();
    return CallerIdConfig.fromMap({});
  }

  Future<void> _loadConfig() async {
    final repository = ref.read(callerIdConfigRepositoryProvider);
    final config = await repository.getConfig();
    if (ref.mounted) {
      state = CallerIdConfig.fromMap(config);
    }
  }

  Future<void> setUseLocalNotification(bool value) async {
    await ref.read(callerIdConfigRepositoryProvider).setUseLocalNotification(value);
    if (ref.mounted) {
      state = state.copyWith(useLocalNotification: value);
    }
  }

  Future<void> setCancelLocalNotification(bool value) async {
    await ref.read(callerIdConfigRepositoryProvider).setCancelLocalNotification(value);
    if (ref.mounted) {
      state = state.copyWith(cancelLocalNotification: value);
    }
  }

  Future<void> setUseStirNotification(bool value) async {
    await ref.read(callerIdConfigRepositoryProvider).setUseStirNotification(value);
    if (ref.mounted) {
      state = state.copyWith(useStirNotification: value);
    }
  }

  Future<void> setDisplayMode(DisplayMode value) async {
    await ref.read(callerIdConfigRepositoryProvider).setDisplayMode(value);
    if (ref.mounted) {
      state = state.copyWith(displayMode: value);
    }
  }

  Future<void> setNotificationAutoCancelDelay(Duration value) async {
    await ref.read(callerIdConfigRepositoryProvider).setNotificationAutoCancelDelay(value);
    if (ref.mounted) {
      state = state.copyWith(notificationAutoCancelDelay: value);
    }
  }
}
