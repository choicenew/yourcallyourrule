import 'dart:async';
import 'package:pyro_user_database_protocol/pyro_user_database_protocol.dart';

/// KOReader kosync protocol adapter implementation for reading progress sync.
class KoReaderSyncAdapter implements SyncDataAdapter<Map<String, dynamic>> {
  final String kosyncServerUrl;
  final String username;
  final String userKey;

  final StreamController<Map<String, dynamic>> _changesController = StreamController.broadcast();

  KoReaderSyncAdapter({
    required this.kosyncServerUrl,
    required this.username,
    required this.userKey,
  });

  @override
  String get moduleId => 'koreader_kosync';

  @override
  String get providerId => moduleId;

  @override
  Future<List<Map<String, dynamic>>> readAll() async {
    return [];
  }

  @override
  Future<void> overwriteAll(List<dynamic> items) async {}

  @override
  Stream<Map<String, dynamic>> watchChanges() => _changesController.stream;

  @override
  Future<void> upsert(Map<String, dynamic> item) async {}

  @override
  Map<String, dynamic> toJson(Map<String, dynamic> item) => item;

  @override
  Map<String, dynamic> fromJson(Map<String, dynamic> json) => json;
}
