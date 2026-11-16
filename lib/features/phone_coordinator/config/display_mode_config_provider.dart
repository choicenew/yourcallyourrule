import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/phone_coordinator/config/display_mode_config_repository.dart';
import 'package:yourcallyourrule/features/phone_coordinator/handlers/display_mode.dart';

final displayModeConfigRepositoryProvider = Provider<DisplayModeConfigRepository>((ref) {
  final configRepository = SharedPreferencesConfigRepository();
  return DisplayModeConfigRepository(configRepository);
});

final displayModeConfigProvider = NotifierProvider<DisplayModeConfigNotifier, DisplayModeConfig>(
  DisplayModeConfigNotifier.new,
);

class DisplayModeConfig {
  final bool useLocalNotification;
  final bool cancelLocalNotification;
  final bool useStirNotification;
  final DisplayMode displayMode;
  final Duration notificationAutoCancelDelay;

  const DisplayModeConfig({
    required this.useLocalNotification,
    required this.cancelLocalNotification,
    required this.useStirNotification,
    required this.displayMode,
    required this.notificationAutoCancelDelay,
  });

  DisplayModeConfig copyWith({
    bool? useLocalNotification,
    bool? cancelLocalNotification,
    bool? useStirNotification,
    DisplayMode? displayMode,
    Duration? notificationAutoCancelDelay,
  }) {
    return DisplayModeConfig(
      useLocalNotification: useLocalNotification ?? this.useLocalNotification,
      cancelLocalNotification: cancelLocalNotification ?? this.cancelLocalNotification,
      useStirNotification: useStirNotification ?? this.useStirNotification,
      displayMode: displayMode ?? this.displayMode,
      notificationAutoCancelDelay: notificationAutoCancelDelay ?? this.notificationAutoCancelDelay,
    );
  }

  factory DisplayModeConfig.fromMap(Map<String, dynamic> map) {
    return DisplayModeConfig(
      useLocalNotification: map[DisplayModeConfigRepository.useLocalNotificationKey] as bool? ?? false,
      cancelLocalNotification: map[DisplayModeConfigRepository.cancelLocalNotificationKey] as bool? ?? false,
      useStirNotification: map[DisplayModeConfigRepository.useStirNotificationKey] as bool? ?? false,
      displayMode: DisplayMode.fromString(map[DisplayModeConfigRepository.displayModeKey]),
      notificationAutoCancelDelay: Duration(seconds: map[DisplayModeConfigRepository.notificationAutoCancelDelayKey] as int? ?? DisplayModeConfigRepository.defaultNotificationAutoCancelDelayInSeconds),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DisplayModeConfigRepository.useLocalNotificationKey: useLocalNotification,
      DisplayModeConfigRepository.cancelLocalNotificationKey: cancelLocalNotification,
      DisplayModeConfigRepository.useStirNotificationKey: useStirNotification,
      DisplayModeConfigRepository.displayModeKey: displayMode.name,
      DisplayModeConfigRepository.notificationAutoCancelDelayKey: notificationAutoCancelDelay.inSeconds,
    };
  }
}

class DisplayModeConfigNotifier extends Notifier<DisplayModeConfig> {
  @override
  DisplayModeConfig build() {
    _loadConfig();
    return DisplayModeConfig.fromMap({});
  }

  Future<void> _loadConfig() async {
    final repository = ref.read(displayModeConfigRepositoryProvider);
    final config = await repository.getConfig();
    if (ref.mounted) {
      state = DisplayModeConfig.fromMap(config);
    }
  }

  Future<void> setUseLocalNotification(bool value) async {
    await ref.read(displayModeConfigRepositoryProvider).setUseLocalNotification(value);
    if (ref.mounted) {
      state = state.copyWith(useLocalNotification: value);
    }
  }

  Future<void> setCancelLocalNotification(bool value) async {
    await ref.read(displayModeConfigRepositoryProvider).setCancelLocalNotification(value);
    if (ref.mounted) {
      state = state.copyWith(cancelLocalNotification: value);
    }
  }

  Future<void> setUseStirNotification(bool value) async {
    await ref.read(displayModeConfigRepositoryProvider).setUseStirNotification(value);
    if (ref.mounted) {
      state = state.copyWith(useStirNotification: value);
    }
  }

  Future<void> setDisplayMode(DisplayMode value) async {
    await ref.read(displayModeConfigRepositoryProvider).setDisplayMode(value);
    if (ref.mounted) {
      state = state.copyWith(displayMode: value);
    }
  }

  Future<void> setNotificationAutoCancelDelay(Duration value) async {
    await ref.read(displayModeConfigRepositoryProvider).setNotificationAutoCancelDelay(value);
    if (ref.mounted) {
      state = state.copyWith(notificationAutoCancelDelay: value);
    }
  }
}
