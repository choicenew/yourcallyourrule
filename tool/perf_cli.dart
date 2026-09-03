import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main(List<String> args) async {
  final cli = PerfCli(args);
  await cli.run();
}

class PerfCli {
  final List<String> rawArgs;
  late final bool runTests;
  late final bool scanCode;
  late final bool scanAssets;
  late final bool isCi;
  late final bool outputGithubSummary;
  late final String outputPath;

  PerfCli(this.rawArgs) {
    runTests = rawArgs.contains('--run-tests') || (!rawArgs.contains('--no-tests') && !rawArgs.contains('--scan-only'));
    scanCode = !rawArgs.contains('--no-scan');
    scanAssets = !rawArgs.contains('--no-assets');
    isCi = rawArgs.contains('--ci') || Platform.environment['CI'] == 'true' || Platform.environment['GITHUB_ACTIONS'] == 'true';
    outputGithubSummary = rawArgs.contains('--github-summary') || Platform.environment['GITHUB_STEP_SUMMARY'] != null;

    final outIdx = rawArgs.indexOf('--output');
    if (outIdx != -1 && outIdx + 1 < rawArgs.length) {
      outputPath = rawArgs[outIdx + 1];
    } else {
      outputPath = 'perf_reports/perf_report.json';
    }
  }

  Future<void> run() async {
    _printBanner();

    final report = <String, dynamic>{
      'timestamp': DateTime.now().toIso8601String(),
      'environment': {
        'os': Platform.operatingSystem,
        'dart_version': Platform.version,
        'is_ci': isCi,
      },
      'benchmark_metrics': <Map<String, dynamic>>[],
      'code_issues': <Map<String, dynamic>>[],
      'asset_issues': <Map<String, dynamic>>[],
      'score': 100,
      'summary': {},
    };

    // 1. 运行性能测试
    if (runTests) {
      print('\n\x1B[36m🚀 [1/3] 执行 Flutter 性能基准测试 (test/perf/)... \x1B[0m');
      final testMetrics = await _executePerfTests();
      report['benchmark_metrics'] = testMetrics;
    } else {
      print('\n\x1B[33m⏩ [1/3] 跳过基准测试执行\x1B[0m');
    }

    // 2. 静态卡顿根因扫描
    if (scanCode) {
      print('\n\x1B[36m🔍 [2/3] 静态扫描 App 代码卡顿隐患与性能坏味道 (lib/)... \x1B[0m');
      final codeIssues = await _scanCodebase();
      report['code_issues'] = codeIssues;
    }

    // 3. 资源体积与内存消耗扫描
    if (scanAssets) {
      print('\n\x1B[36m📦 [3/3] 扫描 Assets 资源体积与显存占用 (assets/)... \x1B[0m');
      final assetData = await _scanAssets();
      report['asset_issues'] = assetData['heavy_assets'];
      report['asset_stats'] = assetData['stats'];
    }

    // 4. 汇总评分与健康度计算
    final scoreData = _calculateHealthScore(report);
    report['score'] = scoreData['score'];
    report['grade'] = scoreData['grade'];
    report['summary'] = scoreData['summary'];

    // 5. 终端打印报告
    _printTerminalReport(report);

    // 6. 导出文件
    await _exportReport(report);

    // 7. 生成 GitHub Step Summary
    if (outputGithubSummary) {
      await _writeGithubStepSummary(report);
    }

    // 如果在 CI 模式下得分过低，可退出非0，但默认宽容保证流水线展示
    print('\n\x1B[32m✔ 性能全流程诊断完成！报告已保存至 $outputPath\x1B[0m\n');
  }

  void _printBanner() {
    print('''
\x1B[35m╔══════════════════════════════════════════════════════════════╗
║               FLUTTER 全性能与卡顿分析 CLI                   ║
║   Runtime Benchmark • Static Hitch Detection • Asset Audit   ║
╚══════════════════════════════════════════════════════════════╝\x1B[0m''');
  }

  Future<List<Map<String, dynamic>>> _executePerfTests() async {
    final metrics = <Map<String, dynamic>>[];
    final isWin = Platform.isWindows;
    String flutterCmd = isWin ? 'flutter.bat' : 'flutter';
    final customPathIdx = rawArgs.indexOf('--flutter-path');
    if (customPathIdx != -1 && customPathIdx + 1 < rawArgs.length) {
      flutterCmd = rawArgs[customPathIdx + 1];
    } else {
      // 智能探测：从当前 dart.exe 回溯查找同 SDK 的 flutter.bat
      try {
        final dartExe = File(Platform.resolvedExecutable);
        // 通常结构是: flutter/bin/cache/dart-sdk/bin/dart.exe 或 flutter/bin/dart
        final possibleFlutter1 = File('${dartExe.parent.parent.parent.parent.path}${Platform.pathSeparator}flutter.bat');
        final possibleFlutter2 = File('${dartExe.parent.parent.parent.path}${Platform.pathSeparator}flutter.bat');
        final possibleFlutter3 = File('${dartExe.parent.path}${Platform.pathSeparator}flutter.bat');
        if (possibleFlutter1.existsSync()) {
          flutterCmd = possibleFlutter1.path;
        } else if (possibleFlutter2.existsSync()) {
          flutterCmd = possibleFlutter2.path;
        } else if (possibleFlutter3.existsSync()) {
          flutterCmd = possibleFlutter3.path;
        }
      } catch (_) {}
    }

    final targetPath = Directory('test/perf').existsSync() ? 'test/perf' : 'test';
    print('   使用 Flutter 执行器: $flutterCmd');
    print('   正在启动 `flutter test $targetPath`...');

    try {
      final process = await Process.start(
        flutterCmd,
        ['test', targetPath],
        runInShell: true,
      );

      final lineStream = process.stdout
          .transform(utf8.decoder)
          .transform(const LineSplitter());

      await for (final line in lineStream) {
        if (line.contains('PERF_METRIC:')) {
          final jsonStart = line.indexOf('{');
          if (jsonStart != -1) {
            try {
              final jsonStr = line.substring(jsonStart);
              final parsed = jsonDecode(jsonStr) as Map<String, dynamic>;
              metrics.add(parsed);
              print('   \x1B[32m⚡ [基准指标]\x1B[0m ${parsed['metric']} -> ${jsonEncode(parsed)}');
            } catch (_) {}
          }
        } else if (line.contains('Test failed') || line.contains('EXCEPTION CAUGHT')) {
          print('   \x1B[31m✖ [测试异常]\x1B[0m $line');
        } else if (line.contains('All tests passed') || line.contains('Some tests failed')) {
          print('   $line');
        }
      }

      await process.exitCode;
    } catch (e) {
      print('   \x1B[31m[执行失败] 无法直接启动 flutter test: $e\x1B[0m');
      print('   提示：在 GitHub Actions 或本地环境中确保 flutter 在系统 PATH 中。');
    }

    return metrics;
  }

  Future<List<Map<String, dynamic>>> _scanCodebase() async {
    final issues = <Map<String, dynamic>>[];
    final libDir = Directory('lib');
    if (!libDir.existsSync()) {
      return issues;
    }

    final dartFiles = libDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart') && !f.path.endsWith('.g.dart') && !f.path.endsWith('.freezed.dart'));

    for (final file in dartFiles) {
      final relPath = file.path.replaceAll('\\', '/');
      final lines = await file.readAsLines();

      bool inBuildMethod = false;
      int buildMethodStartLine = 0;
      int buildBraceDepth = 0;

      for (int i = 0; i < lines.length; i++) {
        final lineNum = i + 1;
        final line = lines[i];
        final trimmed = line.trim();

        // 识别 Widget build(BuildContext context) 开始
        if (trimmed.contains('Widget build(BuildContext context') ||
            trimmed.contains('Widget build(BuildContext context,') ||
            trimmed.contains('Widget build(context')) {
          inBuildMethod = true;
          buildMethodStartLine = lineNum;
          buildBraceDepth = 0;
        }

        if (inBuildMethod) {
          buildBraceDepth += _countOccurrences(line, '{');
          buildBraceDepth -= _countOccurrences(line, '}');

          // 检测 1: Build 方法内直接创建 RegExp / DateFormat 导致高频 GC 顿卡
          if (line.contains('RegExp(') && !line.contains('static') && !line.contains('const')) {
            issues.add({
              'category': 'GC_CHURN_IN_BUILD',
              'severity': 'HIGH',
              'title': 'Build 方法内部动态实例化 RegExp',
              'file': relPath,
              'line': lineNum,
              'cause': '每一帧触发 build 时都会重复编译正则表达式并分配堆内存，引起高频 GC Stop-The-World 导致掉帧。',
              'suggestion': '提取为类级 static final 或 top-level 常量。',
              'code_snippet': trimmed,
            });
          }

          if (line.contains('DateFormat(') && !line.contains('static') && !line.contains('const')) {
            issues.add({
              'category': 'GC_CHURN_IN_BUILD',
              'severity': 'MEDIUM',
              'title': 'Build 方法内部动态实例化 DateFormat',
              'file': relPath,
              'line': lineNum,
              'cause': 'DateFormat 构造开销较大，且每次重构重复创建会导致不必要的垃圾回收。',
              'suggestion': '提取为局部常量或静态缓存实例。',
              'code_snippet': trimmed,
            });
          }

          // build 方法结束检测
          if (buildBraceDepth <= 0 && line.contains('}')) {
            inBuildMethod = false;
            final buildLength = lineNum - buildMethodStartLine;
            // 检测 2: 巨型单体 Build 方法（> 130 行）
            if (buildLength > 130) {
              issues.add({
                'category': 'MONOLITHIC_BUILD',
                'severity': 'HIGH',
                'title': '巨型 Build 方法 ($buildLength 行)',
                'file': relPath,
                'line': buildMethodStartLine,
                'cause': 'Build 函数体积过大（$buildLength 行），局部状态更新会导致整棵深层 Widget 树全量重建，引起布局与绘制卡顿。',
                'suggestion': '拆分为独立的 StatelessWidget，利用 Flutter 的 Element 缓存机制阻断重绘扩散。',
                'code_snippet': 'Widget build(...) 跨度 $buildLength 行',
              });
            }
          }
        }

        // 检测 3: 滥用 Opacity 引发 SaveLayer 离屏渲染
        if (trimmed.startsWith('Opacity(') || trimmed.contains(' Opacity(')) {
          // 如果紧随的不是简单的无子树控件，提示 SaveLayer 隐患
          issues.add({
            'category': 'EXPENSIVE_SAVELAYER',
            'severity': 'MEDIUM',
            'title': '使用 Opacity 导致 GPU SaveLayer 离屏混合',
            'file': relPath,
            'line': lineNum,
            'cause': 'Opacity 控件会强制 Flutter 在 GPU 内存中分配额外的离屏缓冲区并进行多次绘制混合，特别在动画或滚动中造成显著掉帧。',
            'suggestion': '若仅针对颜色透明，优先使用 Color.withValues / withOpacity；若用于淡入淡出动画，使用 AnimatedOpacity。',
            'code_snippet': trimmed,
          });
        }

        // 检测 4: BackdropFilter 滥用
        if (trimmed.contains('BackdropFilter(')) {
          issues.add({
            'category': 'EXPENSIVE_GPU_FILTER',
            'severity': 'MEDIUM',
            'title': '使用 BackdropFilter 导致高 GPU 算力消耗',
            'file': relPath,
            'line': lineNum,
            'cause': 'BackdropFilter 每一帧都需对背景图层执行高斯模糊像素卷积，在低端 Android 机型上极易掉帧。',
            'suggestion': '避免在可滚动的长列表中使用，或限制其影响区域。',
            'code_snippet': trimmed,
          });
        }

        // 检测 5: ListView 默认构造函数直接渲染长数组
        if (trimmed.startsWith('ListView(') && lines.length > i + 1 && lines[i + 1].contains('children:')) {
          issues.add({
            'category': 'NON_VIRTUALIZED_LIST',
            'severity': 'HIGH',
            'title': 'ListView(children: [...]) 未采用虚拟化复用',
            'file': relPath,
            'line': lineNum,
            'cause': '默认 ListView 构造函数会一次性实例化并布局 children 中的所有子项，丧失视图回收机制，数据量大时引发首屏卡死和内存暴涨。',
            'suggestion': '改为使用 ListView.builder 或 ListView.separated 启用动态懒加载。',
            'code_snippet': trimmed,
          });
        }
      }
    }

    return issues;
  }

  Future<Map<String, dynamic>> _scanAssets() async {
    final assetsDir = Directory('assets');
    final heavyAssets = <Map<String, dynamic>>[];
    int totalBytes = 0;
    int assetCount = 0;

    if (assetsDir.existsSync()) {
      final files = assetsDir.listSync(recursive: true).whereType<File>();
      for (final file in files) {
        final bytes = file.lengthSync();
        totalBytes += bytes;
        assetCount++;
        final relPath = file.path.replaceAll('\\', '/');

        // 超大静态资源检测（> 300KB 报警，> 800KB 严重报警）
        if (bytes > 300 * 1024) {
          final sizeKb = (bytes / 1024).toStringAsFixed(1);
          final isCritical = bytes > 800 * 1024;
          heavyAssets.add({
            'file': relPath,
            'size_bytes': bytes,
            'size_kb': sizeKb,
            'severity': isCritical ? 'HIGH' : 'MEDIUM',
            'cause': '超大资源图片在移动设备加载解码时会长时间占用 UI 主线程，且占用巨大 GPU 显存，极易导致启动与切页卡顿。',
            'suggestion': '进行 WebP 压缩或缩放分辨率，将体积控制在 150KB 以内。',
          });
        }
      }
    }

    heavyAssets.sort((a, b) => (b['size_bytes'] as int).compareTo(a['size_bytes'] as int));

    return {
      'heavy_assets': heavyAssets,
      'stats': {
        'total_files': assetCount,
        'total_size_mb': (totalBytes / (1024 * 1024)).toStringAsFixed(2),
        'heavy_count': heavyAssets.length,
      },
    };
  }

  Map<String, dynamic> _calculateHealthScore(Map<String, dynamic> report) {
    int score = 100;

    final codeIssues = (report['code_issues'] as List).cast<Map<String, dynamic>>();
    final assetIssues = (report['asset_issues'] as List).cast<Map<String, dynamic>>();
    final benchmarks = (report['benchmark_metrics'] as List).cast<Map<String, dynamic>>();

    int highCount = 0;
    int mediumCount = 0;
    int jankFrameCount = 0;

    for (final issue in codeIssues) {
      if (issue['severity'] == 'HIGH') {
        highCount++;
        score -= 5;
      } else {
        mediumCount++;
        score -= 2;
      }
    }

    for (final asset in assetIssues) {
      if (asset['severity'] == 'HIGH') {
        highCount++;
        score -= 6;
      } else {
        mediumCount++;
        score -= 2;
      }
    }

    for (final bench in benchmarks) {
      if (bench['jank_frames_above_16ms'] != null) {
        final jank = bench['jank_frames_above_16ms'] as int;
        if (jank > 0) {
          jankFrameCount += jank;
          score -= min(15, (jank * 0.5).round());
        }
      }
    }

    score = max(20, min(100, score));

    String grade = 'A';
    if (score >= 90) {
      grade = 'A (优异)';
    } else if (score >= 80) {
      grade = 'B (良好)';
    } else if (score >= 70) {
      grade = 'C (有卡顿隐患)';
    } else {
      grade = 'D (存在严重性能瓶颈)';
    }

    return {
      'score': score,
      'grade': grade,
      'summary': {
        'total_issues': codeIssues.length + assetIssues.length,
        'high_severity': highCount,
        'medium_severity': mediumCount,
        'jank_frames_detected': jankFrameCount,
      }
    };
  }

  void _printTerminalReport(Map<String, dynamic> report) {
    final score = report['score'];
    final grade = report['grade'];
    final summary = report['summary'] as Map<String, dynamic>;
    final benchmarks = (report['benchmark_metrics'] as List).cast<Map<String, dynamic>>();
    final codeIssues = (report['code_issues'] as List).cast<Map<String, dynamic>>();
    final assetIssues = (report['asset_issues'] as List).cast<Map<String, dynamic>>();

    print('\n\x1B[1m══════════════════════════════════════════════════════════════\x1B[0m');
    print('\x1B[1m📊 性能分析诊断结果汇总\x1B[0m');
    print('══════════════════════════════════════════════════════════════');
    print('综合健康得分: \x1B[33m$score 分\x1B[0m  |  评级: \x1B[32m$grade\x1B[0m');
    print('高风险卡顿项: \x1B[31m${summary['high_severity']}\x1B[0m 个  |  中风险项: \x1B[33m${summary['medium_severity']}\x1B[0m 个');

    if (benchmarks.isNotEmpty) {
      print('\n\x1B[34m[⚡ 运行时基准性能测试指标]\x1B[0m');
      for (final m in benchmarks) {
        final name = m['metric'] ?? 'unknown';
        if (m['avg_frame_ms'] != null) {
          print('  • $name: 平均帧耗时 ${m['avg_frame_ms']?.toStringAsFixed(2)}ms, P95: ${m['p95_frame_ms']?.toStringAsFixed(2)}ms, 掉帧(>16ms): ${m['jank_frames_above_16ms']} 帧');
        } else {
          final durationVal = m['total_ms'] ?? m['elapsed_ms'] ?? m['mount_ms'];
          final totalStr = durationVal != null ? '${(durationVal as num).toStringAsFixed(2)}ms' : '-';
          print('  • $name: 耗时 $totalStr ${m['qps'] != null ? '(QPS: ${m['qps']})' : ''}');
        }
      }
    }

    if (codeIssues.isNotEmpty) {
      print('\n\x1B[31m[⚠️ 代码卡顿与性能坏味道 Top 命中]\x1B[0m');
      final topIssues = codeIssues.take(8);
      for (final issue in topIssues) {
        final color = issue['severity'] == 'HIGH' ? '\x1B[31m' : '\x1B[33m';
        print('  $color[${issue['severity']}]\x1B[0m ${issue['title']}');
        print('    位置: ${issue['file']}:${issue['line']}');
        print('    原因: ${issue['cause']}');
        print('    建议: ${issue['suggestion']}\n');
      }
      if (codeIssues.length > 8) {
        print('    ... 还有 ${codeIssues.length - 8} 处性能警告已写入完整报告文件。');
      }
    }

    if (assetIssues.isNotEmpty) {
      print('\x1B[33m[🖼️ 超大图片与资源显存占用排行]\x1B[0m');
      for (final a in assetIssues.take(5)) {
        print('  • ${a['file']} (${a['size_kb']} KB) -> 解码耗时高，易致卡顿');
      }
    }
    print('══════════════════════════════════════════════════════════════');
  }

  Future<void> _exportReport(Map<String, dynamic> report) async {
    final file = File(outputPath);
    if (!file.parent.existsSync()) {
      file.parent.createSync(recursive: true);
    }
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(report));

    // 默认始终导出本地 Markdown 摘要报表
    final mdReportPath = outputPath.replaceAll('.json', '.md');
    final mdContent = _generateMarkdownReport(report);
    final mdFile = File(mdReportPath);
    await mdFile.writeAsString(mdContent);
  }

  Future<void> _writeGithubStepSummary(Map<String, dynamic> report) async {
    final summaryPath = Platform.environment['GITHUB_STEP_SUMMARY'];
    final mdContent = _generateMarkdownReport(report);

    if (summaryPath != null && summaryPath.isNotEmpty) {
      try {
        final summaryFile = File(summaryPath);
        await summaryFile.writeAsString(mdContent, mode: FileMode.append);
        print('   \x1B[32m✔ 已成功将 Markdown 报告写入 GITHUB_STEP_SUMMARY\x1B[0m');
      } catch (e) {
        print('   \x1B[33m写入 GITHUB_STEP_SUMMARY 失败: $e\x1B[0m');
      }
    }
  }

  String _generateMarkdownReport(Map<String, dynamic> report) {
    final buffer = StringBuffer();

    final score = report['score'];
    final grade = report['grade'];
    final summary = report['summary'] as Map<String, dynamic>;
    final benchmarks = (report['benchmark_metrics'] as List).cast<Map<String, dynamic>>();
    final codeIssues = (report['code_issues'] as List).cast<Map<String, dynamic>>();
    final assetIssues = (report['asset_issues'] as List).cast<Map<String, dynamic>>();

    final scoreBadge = score >= 85 ? '🟢' : (score >= 70 ? '🟡' : '🔴');

    buffer.writeln('# $scoreBadge Flutter App 性能与卡顿深度诊断报告');
    buffer.writeln();
    buffer.writeln('| 评估维度 | 检测结果 | 说明 |');
    buffer.writeln('| :--- | :--- | :--- |');
    buffer.writeln('| **综合健康得分** | **$score / 100** ($grade) | 包含基准耗时、卡顿反模式及显存占比 |');
    buffer.writeln('| **高危卡顿隐患** | `${summary['high_severity']}` 处 | 包含大 Build 重建风暴、正则频繁创建等 |');
    buffer.writeln('| **中危性能隐患** | `${summary['medium_severity']}` 处 | 包含 SaveLayer 离屏混合、超大图片等 |');
    buffer.writeln('| **掉帧情况** | `${summary['jank_frames_detected']}` 次 | 单帧渲染耗时突破 16.6ms 阈值 |');
    buffer.writeln();

    if (benchmarks.isNotEmpty) {
      buffer.writeln('### ⚡ 运行时基准性能耗时 (Runtime Benchmark)');
      buffer.writeln('| 指标名称 | 测算耗时 | 吞吐量 / 掉帧率 | 性能评定 |');
      buffer.writeln('| :--- | :--- | :--- | :--- |');
      for (final m in benchmarks) {
        final name = m['metric'] ?? 'Benchmark';
        if (m['avg_frame_ms'] != null) {
          final avg = (m['avg_frame_ms'] as num).toStringAsFixed(2);
          final jank = m['jank_frames_above_16ms'];
          final status = (m['avg_frame_ms'] as num) < 16.6 ? '🟢 流畅' : '🔴 存在掉帧';
          buffer.writeln('| **$name** | 平均 ${avg}ms (P95: ${(m['p95_frame_ms'] as num).toStringAsFixed(2)}ms) | 掉帧: $jank 帧 | $status |');
        } else {
          final durationVal = m['total_ms'] ?? m['elapsed_ms'] ?? m['mount_ms'];
          final total = durationVal != null ? (durationVal as num).toStringAsFixed(2) : '-';
          final qps = m['qps'] != null ? '${m['qps']} ops/s' : '-';
          buffer.writeln('| **$name** | 总耗时 ${total}ms | $qps | 🟢 正常 |');
        }
      }
      buffer.writeln();
    }

    if (codeIssues.isNotEmpty) {
      buffer.writeln('### 🔍 代码卡顿隐患清单 (Hitch & Stutter Anti-Patterns)');
      buffer.writeln('| 严重度 | 问题分类 | 文件位置 | 致卡原因与优化建议 |');
      buffer.writeln('| :---: | :--- | :--- | :--- |');
      for (final issue in codeIssues.take(20)) {
        final icon = issue['severity'] == 'HIGH' ? '🔴 **高危**' : '🟡 **中危**';
        final link = '`${issue['file']}:${issue['line']}`';
        buffer.writeln('| $icon | ${issue['title']} | $link | **原因**: ${issue['cause']}<br/>💡 **建议**: ${issue['suggestion']} |');
      }
      buffer.writeln();
    }

    if (assetIssues.isNotEmpty) {
      buffer.writeln('### 📦 超大图片资产检测 (显存与首屏解码瓶颈)');
      buffer.writeln('| 资源文件 | 文件体积 | 影响分析 | 建议 |');
      buffer.writeln('| :--- | :--- | :--- | :--- |');
      for (final a in assetIssues) {
        buffer.writeln('| `${a['file']}` | **${a['size_kb']} KB** | 解码阻塞主线程，占用 GPU 显存 | 压缩为 WebP 或降低分辨率 |');
      }
      buffer.writeln();
    }

    buffer.writeln('> 💡 *本报告由性能 CLI (tool/perf_cli.dart) 自动生成，未触碰主应用任何源码。*');
    return buffer.toString();
  }

  int _countOccurrences(String source, String char) {
    int count = 0;
    int idx = 0;
    while ((idx = source.indexOf(char, idx)) != -1) {
      count++;
      idx += char.length;
    }
    return count;
  }
}
