import 'dart:convert';
import 'dart:io';
import 'package:yourcallyourrule/core/entities/cloud_data_converter.dart';
import 'package:yourcallyourrule/core/entities/label/label_entry.dart';
import 'package:yourcallyourrule/core/entities/location/location_entry.dart';
import 'package:yourcallyourrule/cloud_sync/services/local_storage_service.dart';
import 'package:yourcallyourrule/core/entities/rule/rule_base.dart';

class RuleImportExportService {
  final LocalStorageService _storage;
  //final CloudDataConverter _converter;

  RuleImportExportService(this._storage);

  LocalStorageService get storage => _storage;

  Future<File> exportRulePackage(String filePath, {
    bool includeLabels = true,
    bool includeLocations = true,
  }) async {
    final package = {
      'rules': CloudDataConverter.serialize(await _storage.loadRules()),
      'labels': includeLabels 
          ? CloudDataConverter.serialize(await _storage.loadLabels()) 
          : [],
      'locations': includeLocations
          ? CloudDataConverter.serialize(await _storage.loadLocations())
          : [],
    };

    return await _writeToFile(filePath, package);
  }

  Future<void> importRulePackage(File file) async {
    final package = await _readFromFile(file);
    
    await _storage.saveRules(_convertList<RuleBase>(package['rules']));
    await _storage.saveLabels(_convertList<LabelEntry>(package['labels']));
    await _storage.saveLocations(_convertList<LocationEntry>(package['locations']));
  }

  List<T> _convertList<T>(dynamic data) {
    return (data as List).map((e) => CloudDataConverter.deserialize<T>(e)).toList();
  }

  Future<File> _writeToFile(String path, dynamic data) async {
    final file = File(path);
    await file.writeAsString(jsonEncode(data));
    return file;
  }

  Future<Map<String, dynamic>> _readFromFile(File file) async {
    final content = await file.readAsString();
    final data = jsonDecode(content) as Map<String, dynamic>;
    
    if (!data.containsKey('rules')) {
      throw const FormatException('Invalid rule package format');
    }
    
    return data;
  }
}