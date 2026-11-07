import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/call_overlay_config.dart';
import 'call_overlay_config_service.dart';

class CallOverlayImportExportService {
  final CallOverlayConfigService _configService;

  CallOverlayImportExportService(this._configService);

  Future<void> importConfig(File file) async {
    final content = await file.readAsString();
    final configMap = jsonDecode(content) as Map<String, dynamic>;
    await _configService.saveConfig(CallOverlayConfig.fromMap(configMap));
  }

  Future<File> exportConfig() async {
    final config = await _configService.loadConfig();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/call_overlay_config.json');
    return file.writeAsString(jsonEncode(config?.toMap() ?? {}));
  }
}