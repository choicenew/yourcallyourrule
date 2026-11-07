import 'package:pyro_sync_protocol/pyro_sync_protocol.dart';

class JsonSyncProtocol<T> {
  final SyncDataAdapter<T> _adapter;
  JsonSyncProtocol(this._adapter);

  Future<List<Map<String, dynamic>>> exportFullJson() async {
    final items = await _adapter.readAll();
    return items.map((e) => _adapter.toJson(e)).toList();
  }

  Future<void> importFullJson(List<Map<String, dynamic>> jsonList) async {
    final items = jsonList.map((e) => _adapter.fromJson(e)).toList();
    await _adapter.overwriteAll(items);
  }
}
