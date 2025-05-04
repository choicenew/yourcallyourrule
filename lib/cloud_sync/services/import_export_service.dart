import 'dart:convert';
import 'dart:io';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/cloud_sync/services/local_storage_service.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

class ImportExportService {
  final LocalStorageService _localStorage;
  //final CloudDataConverter _converter;

  ImportExportService(this._localStorage);

  Future<File> exportData({
    required String filePath,
    bool includeRules = true,
    bool includeContacts = true,
    bool includePlugins = true,
  }) async {
    final data = <String, dynamic>{};

    if (includeRules) {
      data['rules'] = CloudDataConverter.serialize(await _localStorage.loadRules());
    }
    if (includeContacts) {
      data['contacts'] = CloudDataConverter.serialize(await _localStorage.loadContacts());
    }
    if (includePlugins) {
      data['plugins'] = CloudDataConverter.serialize(await _localStorage.loadPlugins());
    }

    final file = File(filePath);
    await file.writeAsString(jsonEncode(data));
    return file;
  }

  Future<void> importData(File file) async {
    final content = await file.readAsString();
    final data = jsonDecode(content) as Map<String, dynamic>;

    _validateDataFormat(data);

    if (data.containsKey('rules')) {
      await _localStorage.saveRules(
        (data['rules'] as List).map((e) => CloudDataConverter.deserialize<RuleBase>(e)).toList(),
      );
    }

    if (data.containsKey('contacts')) {
      await _localStorage.saveContacts(
        (data['contacts'] as List).map((e) => CloudDataConverter.deserialize<Contact>(e)).toList(),
      );
    }

    if (data.containsKey('plugins')) {
      await _localStorage.savePlugins(
        (data['plugins'] as List).map((e) => CloudDataConverter.deserialize<PluginEntry>(e)).toList(),
      );
    }
  }

  void _validateDataFormat(Map<String, dynamic> data) {
    final validKeys = {'rules', 'contacts', 'plugins'};
    final invalidKeys = data.keys.where((key) => !validKeys.contains(key));
    
    if (invalidKeys.isNotEmpty) {
      throw FormatException('Invalid data format. Unexpected keys: ${invalidKeys.join(', ')}');
    }
  }
}