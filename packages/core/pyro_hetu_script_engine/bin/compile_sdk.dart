import 'dart:io';
import 'package:hetu_script/hetu_script.dart';

void main() async {
  final hetu = Hetu();
  hetu.init();

  // Smart auto-adapting path resolution
  Directory libDir;
  final scriptDir = File(Platform.script.toFilePath()).parent.parent;
  final candidatePath = '${scriptDir.path}/lib/src';

  if (Directory(candidatePath).existsSync()) {
    libDir = Directory(candidatePath);
  } else if (Directory('packages/core/pyro_hetu_script_engine/lib/src').existsSync()) {
    libDir = Directory('packages/core/pyro_hetu_script_engine/lib/src');
  } else {
    libDir = Directory('lib/src');
  }

  if (!libDir.existsSync()) {
    print('❌ Error: lib/src directory not found.');
    exit(1);
  }

  print('🚀 Compiling SDK modules to bytecode from: ${libDir.path}');

  final files = libDir.listSync(recursive: true);
  int count = 0;

  for (final file in files) {
    if (file is File && file.path.endsWith('.ht')) {
      try {
        final source = file.readAsStringSync();
        final bytes = hetu.compile(source);

        final outPath = file.path.replaceAll('.ht', '.out');
        File(outPath).writeAsBytesSync(bytes);

        print('  ✅ Compiled: ${file.path} -> $outPath');
        count++;
      } catch (e) {
        print('  ❌ Failed to compile ${file.path}: $e');
      }
    }
  }

  print('\n🎉 Done! Compiled $count modules to .out bytecode.');
}
