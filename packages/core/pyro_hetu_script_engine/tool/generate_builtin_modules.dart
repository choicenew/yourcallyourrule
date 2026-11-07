import 'dart:io';
import 'package:hetu_script/hetu_script.dart';
import 'package:path/path.dart' as p;

/// 自动扫描所有的 .ht 脚本并编译生成纯二进制字节码字典 pyro_sdk_precompiled_modules.dart (0-eval)
void main() {
  // 1. 定位工程目录
  final engineDir = Directory.current.path.endsWith('pyro_hetu_script_engine')
      ? Directory.current
      : Directory('packages/core/pyro_hetu_script_engine');

  final stdDir = Directory(p.join(engineDir.path, 'lib', 'src', 'std'));
  final sdkDir = Directory(p.join(engineDir.path, 'lib', 'src', 'sdk'));

  final hetu = Hetu();
  hetu.init();

  final bytecodes = <String, List<int>>{};

  // 2. 自动递归扫描 std 和 sdk 目录下的全部 .ht 文件并调用编译器预编译为二进制字节码
  for (final dir in [stdDir, sdkDir]) {
    if (!dir.existsSync()) continue;
    for (final entity in dir.listSync(recursive: true)) {
      if (entity is File && entity.path.endsWith('.ht')) {
        final fileName = p.basenameWithoutExtension(entity.path);
        final content = entity.readAsStringSync();

        final standardModuleId = 'module:$fileName';
        final compiledBytes = hetu.compile(content, filename: standardModuleId);

        bytecodes[standardModuleId] = compiledBytes.toList();
        bytecodes[fileName] = compiledBytes.toList();
      }
    }
  }

  // 3. 自动绑定所有内置系统别名 (如 module:host_webview -> module:webview)
  final aliasMap = {
    'module:host_webview': 'module:webview',
    'module:host_user': 'module:user',
    'module:host_config': 'module:config',
    'module:host_storage': 'module:storage',
    'module:host_html': 'module:html',
    'module:host_translation': 'module:translation',
    'module:location': 'module:device',
    'module:motion': 'module:device',
    'module:network': 'module:device',
    'module:time': 'module:device',
    'host_webview': 'module:webview',
    'host_user': 'module:user',
    'host_config': 'module:config',
    'host_storage': 'module:storage',
    'host_html': 'module:html',
    'host_translation': 'module:translation',
    'location': 'module:device',
    'motion': 'module:device',
    'network': 'module:device',
    'time': 'module:device',
  };

  for (final entry in aliasMap.entries) {
    if (bytecodes.containsKey(entry.value)) {
      bytecodes[entry.key] = bytecodes[entry.value]!;
    }
  }

  // 4. 构造生成的 Dart 预编译代码内容
  final buffer = StringBuffer();
  buffer.writeln('// -------------------------------------------------------------');
  buffer.writeln('// 自动生成预编译二进制字节码文件，请勿手动修改！');
  buffer.writeln('// 运行命令: dart run tool/generate_builtin_modules.dart');
  buffer.writeln('// -------------------------------------------------------------');
  buffer.writeln();
  buffer.writeln("import 'dart:typed_data';");
  buffer.writeln();
  buffer.writeln('/// Pyro 引擎内置标准库与 SDK 模块的预编译二进制字节码数据源 (Zero eval / Zero AST)');
  buffer.writeln('class PyroSdkPrecompiledModules {');
  buffer.writeln('  static final Map<String, Uint8List> bytecodes = {');

  for (final entry in bytecodes.entries) {
    buffer.write("    r'''${entry.key}''': Uint8List.fromList([");
    buffer.write(entry.value.join(', '));
    buffer.writeln(']),');
  }

  buffer.writeln('  };');
  buffer.writeln('}');

  // 5. 写出到目标文件
  final outFile = File(p.join(sdkDir.path, 'pyro_sdk_precompiled_modules.dart'));
  outFile.writeAsStringSync(buffer.toString());

  print('✅ 成功自动生成 0-eval 预编译二进制字节码字典：${bytecodes.length} 个资源键！');
}
