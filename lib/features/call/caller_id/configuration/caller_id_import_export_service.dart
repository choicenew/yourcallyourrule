import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/features/call/caller_id/configuration/caller_id_config.dart';
import 'caller_id_config_service.dart';

class CallerIdImportExportService {
  final CallerIdConfigService _configService;

  CallerIdImportExportService(this._configService);

  Future<void> importConfig(File file) async {
    final content = await file.readAsString();
    final configMap = jsonDecode(content) as Map<String, dynamic>;
    await _configService.saveConfig(CallerIdConfig.fromMap(configMap));
  }

  Future<File> exportConfig() async {
    final config = await _configService.loadConfig();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/caller_id_config.json');
    return file.writeAsString(jsonEncode(config?.toMap() ?? {}));
  }
}