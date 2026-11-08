import 'package:riverpod/riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Supabase configuration model
class SupabaseConfig {
  final String url;
  final String anonKey;
  final String connectionString;
  final bool isMasterDevice;
  final bool syncCallLogs;
  final int syncIntervalHours;

  const SupabaseConfig({
    this.url = '',
    this.anonKey = '',
    this.connectionString = '',
    this.isMasterDevice = false,
    this.syncCallLogs = true,
    this.syncIntervalHours = 24,
  });

  SupabaseConfig copyWith({
    String? url,
    String? anonKey,
    String? connectionString,
    bool? isMasterDevice,
    bool? syncCallLogs,
    int? syncIntervalHours,
  }) {
    return SupabaseConfig(
      url: url ?? this.url,
      anonKey: anonKey ?? this.anonKey,
      connectionString: connectionString ?? this.connectionString,
      isMasterDevice: isMasterDevice ?? this.isMasterDevice,
      syncCallLogs: syncCallLogs ?? this.syncCallLogs,
      syncIntervalHours: syncIntervalHours ?? this.syncIntervalHours,
    );
  }
}

/// Config provider with secure storage
class SupabaseConfigNotifier extends Notifier<AsyncValue<SupabaseConfig>> {
  static const _storage = FlutterSecureStorage();

  // Storage keys
  static const _keyUrl = 'supabase_url';
  static const _keyAnonKey = 'supabase_anon_key';
  static const _keyConnString = 'supabase_connection_string';
  static const _keyIsMaster = 'supabase_is_master';
  static const _keyCallLogs = 'supabase_sync_call_logs';
  static const _keySyncInterval = 'supabase_sync_interval';

  @override
  AsyncValue<SupabaseConfig> build() {
    _loadConfig();
    return const AsyncValue.loading();
  }

  Future<void> _loadConfig() async {
    state = const AsyncValue.loading();
    try {
      final values = await Future.wait([
        _storage.read(key: _keyUrl),
        _storage.read(key: _keyAnonKey),
        _storage.read(key: _keyConnString),
        _storage.read(key: _keyIsMaster),
        _storage.read(key: _keyCallLogs),
        _storage.read(key: _keySyncInterval),
      ]);

      final config = SupabaseConfig(
        url: values[0] ?? '',
        anonKey: values[1] ?? '',
        connectionString: values[2] ?? '',
        isMasterDevice: values[3] == 'true',
        syncCallLogs: values[4] != 'false', // default true
        syncIntervalHours: int.tryParse(values[5] ?? '24') ?? 24,
      );

      state = AsyncValue.data(config);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveSettings({
    required String url,
    required String anonKey,
    required String connectionString,
  }) async {
    final current = state.value ?? const SupabaseConfig();

    await Future.wait([
      _storage.write(key: _keyUrl, value: url),
      _storage.write(key: _keyAnonKey, value: anonKey),
      _storage.write(key: _keyConnString, value: connectionString),
    ]);

    state = AsyncValue.data(current.copyWith(
      url: url,
      anonKey: anonKey,
      connectionString: connectionString,
    ));
  }

  Future<void> toggleMasterDevice(bool value) async {
    await _storage.write(key: _keyIsMaster, value: value.toString());
    final current = state.value;
    if (current != null) {
      state = AsyncValue.data(current.copyWith(isMasterDevice: value));
    }
  }

  Future<void> toggleCallLogs(bool value) async {
    await _storage.write(key: _keyCallLogs, value: value.toString());
    final current = state.value;
    if (current != null) {
      state = AsyncValue.data(current.copyWith(syncCallLogs: value));
    }
  }

  Future<void> setSyncInterval(int hours) async {
    await _storage.write(key: _keySyncInterval, value: hours.toString());
    final current = state.value;
    if (current != null) {
      state = AsyncValue.data(current.copyWith(syncIntervalHours: hours));
    }
  }
}

final supabaseConfigProvider =
    NotifierProvider<SupabaseConfigNotifier, AsyncValue<SupabaseConfig>>(() {
  return SupabaseConfigNotifier();
});
