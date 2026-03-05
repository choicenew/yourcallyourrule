import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_entry.dart';
import 'package:path/path.dart' as p;

class PluginScriptService {
  Future<String> get _pluginDir async {
    final appSupportDir = await getApplicationSupportDirectory();
    final pluginPath = p.join(appSupportDir.path, 'plugins');
    final dir = Directory(pluginPath);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return pluginPath;
  }

  Future<String> getScript(PluginEntry plugin) async {
    final dir = await _pluginDir;
    final scriptFile = File(p.join(dir, '${plugin.id}.js'));
    if (await scriptFile.exists()) {
      return await scriptFile.readAsString();
    }
    return '';
  }

  Future<void> saveScript(PluginEntry plugin, String scriptContent) async {
    final dir = await _pluginDir;
    final scriptFile = File(p.join(dir, '${plugin.id}.js'));
    await scriptFile.writeAsString(scriptContent);
  }
}