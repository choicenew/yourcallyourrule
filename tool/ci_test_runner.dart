import 'dart:convert';
import 'dart:io';
import 'dart:math';

void main(List<String> args) async {
  final isCi = args.contains('--ci') ||
      Platform.environment['CI'] == 'true' ||
      Platform.environment['GITHUB_ACTIONS'] == 'true';
  final failOnHigh = args.contains('--fail-high');
  final testDirs = ['test/ci'];

  final summaryPath = Platform.environment['GITHUB_STEP_SUMMARY'];
  final envPath = Platform.environment['GITHUB_ENV'];

  final allMetrics = <Map<String, dynamic>>[];
  final allFailures = <String>[];
  final groupResults = <String, _GroupResult>{};

  _printBanner(isCi);

  String flutterCmd = Platform.isWindows ? 'flutter.bat' : 'flutter';
  final flutterIdx = args.indexOf('--flutter-path');
  if (flutterIdx != -1 && flutterIdx + 1 < args.length) {
    flutterCmd = args[flutterIdx + 1];
  }

  final runId = DateTime.now().millisecondsSinceEpoch;
  final reportDir = Directory('ci_reports');
  if (!reportDir.existsSync()) reportDir.createSync(recursive: true);

  for (final dir in testDirs) {
    final d = Directory(dir);
    if (!d.existsSync()) {
      print('\n\x1B[33m⏩ 跳过不存在的测试目录: $dir\x1B[0m');
      continue;
    }
    final files = d
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('_test.dart'))
        .toList();
    print('\n\x1B[36m📁 发现目录 $dir 中有 ${files.length} 个测试文件:\x1B[0m');
    for (final f in files) {
      print('   • ${f.uri.pathSegments.last}');
    }

    for (final file in files) {
      final groupName = file.uri.pathSegments.last.replaceAll('_test.dart', '');
      final sw = Stopwatch()..start();
      final result = await _runFlutterTest(flutterCmd, file.path);
      sw.stop();

      final groupRes = _GroupResult(
        name: groupName,
        file: file.path,
        durationMs: sw.elapsedMicroseconds / 1000.0,
        passed: result['passed'] as bool,
        exitCode: result['exitCode'] as int,
        testCount: result['testCount'] as int,
        metrics: List<Map<String, dynamic>>.from(result['metrics'] ?? []),
      );
      groupResults[groupName] = groupRes;
      allMetrics.addAll(groupRes.metrics);

      if (!groupRes.passed) {
        allFailures.add(groupName);
      }
    }
  }

  final overall = _synthesizeOverall(allMetrics, allFailures, groupResults);
  _printConsoleReport(overall, groupResults);

  final jsonPath =
      '${reportDir.path}/ci_test_report_$runId.json';
  final mdPath =
      '${reportDir.path}/ci_test_report_$runId.md';
  await File(jsonPath)
      .writeAsString(const JsonEncoder.withIndent('  ').convert(overall));
  final md = _renderMarkdown(overall, groupResults);
  await File(mdPath).writeAsString(md);
  print('\n\x1B[32m✔ 报告已保存:\n   - JSON: $jsonPath\n   - MD:   $mdPath\x1B[0m');

  if (summaryPath != null && summaryPath.isNotEmpty) {
    try {
      await File(summaryPath).writeAsString(md, mode: FileMode.append);
      print('\x1B[32m✔ 已写入 GITHUB_STEP_SUMMARY\x1B[0m');
    } catch (e) {
      print('\x1B[33m⚠ 写入 GITHUB_STEP_SUMMARY 失败: $e\x1B[0m');
    }
  }

  if (envPath != null && envPath.isNotEmpty) {
    try {
      final sb = StringBuffer();
      sb.writeln('CI_OVERALL_SCORE=${overall['score']}');
      sb.writeln('CI_GRADE=${(overall['grade'] as String).replaceAll(' ', '_')}');
      sb.writeln('CI_FAIL_COUNT=${allFailures.length}');
      sb.writeln('CI_TOTAL_METRICS=${allMetrics.length}');
      await File(envPath).writeAsString(sb.toString(), mode: FileMode.append);
    } catch (_) {}
  }

  final shouldFail = allFailures.isNotEmpty ||
      (failOnHigh && (overall['high_regressions'] as int) > 0);

  final exitCode = shouldFail ? 1 : 0;
  final statusEmoji = exitCode == 0 ? '✅' : '❌';
  print('\n$statusEmoji 综合评定: 分数 ${overall['score']}/100  |  评级: ${overall['grade']}  |  退出码: $exitCode');
  exit(exitCode);
}

void _printBanner(bool isCi) {
  final env = isCi ? 'GITHUB ACTIONS CI' : 'LOCAL';
  print('''
\x1B[35m╔══════════════════════════════════════════════════════════════════╗
║    FLUTTER 端到端综合 CI 测试套件 (UI / Service / Provider / 性能)  ║
║     运行环境: $env  │  不修改主应用源码, 纯独立测试                    ║
╚══════════════════════════════════════════════════════════════════╝\x1B[0m
''');
}

Future<Map<String, dynamic>> _runFlutterTest(
    String flutterCmd, String filePath) async {
  final metrics = <Map<String, dynamic>>[];
  int testCount = 0;
  bool hasAllPassed = true;
  int exitCode = 0;

  final processArgs = [
    'test',
    filePath,
    '--reporter',
    'expanded',
    '--timeout',
    '120s',
    '-r',
    'github',
  ];

  print('\n\x1B[1m\x1B[34m▶ 启动测试: $filePath\x1B[0m');
  print('   命令: $flutterCmd ${processArgs.join(' ')}');

  try {
    final process = await Process.start(
      flutterCmd,
      processArgs,
      runInShell: true,
    );

    final lineStream = process.stdout
        .transform(utf8.decoder)
        .transform(const LineSplitter());

    await for (final line in lineStream) {
      if (line.contains('CI_METRIC:')) {
        final idx = line.indexOf('{');
        if (idx != -1) {
          try {
            final jsonStr = line.substring(idx);
            final parsed = jsonDecode(jsonStr) as Map<String, dynamic>;
            metrics.add(parsed);
            final cat = parsed['category'] ?? '?';
            final name = parsed['metric'] ?? '?';
            final v = parsed['value'] ?? parsed['total_ms'] ?? '-';
            final unit = parsed['unit'] ?? '';
            print('   \x1B[32m  📊 [$cat]\x1B[0m $name = $v $unit');
          } catch (e) {
            stderr.writeln('      解析 CI_METRIC 失败: $e in $line');
          }
        }
      } else if (line.contains(RegExp(r'^(\+[0-9]+.*:.*|\d+:\d+\s+\+[0-9]+)'))) {
        final match = RegExp(r'\+(\d+)').firstMatch(line);
        if (match != null && testCount == 0) {
          testCount = int.tryParse(match.group(1)!) ?? 0;
        }
      } else if (line.contains('Some tests failed') ||
          line.contains('Test failed') ||
          line.contains('EXCEPTION CAUGHT')) {
        hasAllPassed = false;
        print('   \x1B[31m✖\x1B[0m $line');
      } else if (line.contains('All tests passed')) {
        hasAllPassed = true;
        print('   \x1B[32m✔\x1B[0m $line');
      } else if (line.startsWith('00:')) {
        // Test step lines
        if (line.contains('loading') || line.contains('compiling')) {
          // skip noisy
        } else {
          // uncomment for verbose: print('   $line');
        }
      }
    }

    exitCode = await process.exitCode;

    // stderr passthrough
    final err = await process.stderr
        .transform(utf8.decoder)
        .join();
    if (err.isNotEmpty) {
      stderr.writeln('\x1B[31m   [stderr]\x1B[0m ${err.substring(0, min(err.length, 2000))}');
    }
  } catch (e) {
    stderr.writeln('\x1B[31m   执行异常: $e\x1B[0m');
    hasAllPassed = false;
    exitCode = 127;
  }

  hasAllPassed = hasAllPassed && exitCode == 0;

  return {
    'passed': hasAllPassed,
    'exitCode': exitCode,
    'testCount': testCount,
    'metrics': metrics,
  };
}

Map<String, dynamic> _synthesizeOverall(
  List<Map<String, dynamic>> allMetrics,
  List<String> failures,
  Map<String, _GroupResult> groups,
) {
  int score = 100;
  int highRegressions = 0;
  int warnCount = 0;
  int infoCount = 0;

  final perCategory = <String, List<Map<String, dynamic>>>{};
  for (final m in allMetrics) {
    final cat = (m['category'] as String?) ?? 'UNKNOWN';
    perCategory.putIfAbsent(cat, () => []).add(m);

    final threshold = m['threshold_hard'] as num?;
    final warnThreshold = m['threshold_warn'] as num?;
    final v = m['value'] as num?;
    if (v != null) {
      if (threshold != null && v > threshold) {
        score -= 6;
        highRegressions++;
      } else if (warnThreshold != null && v > warnThreshold) {
        score -= 2;
        warnCount++;
      } else {
        infoCount++;
      }
    }
  }

  // Failure penalties
  score -= failures.length * 10;
  score = max(0, min(100, score));

  String grade;
  if (score >= 90) {
    grade = 'A 优秀 (Excellent)';
  } else if (score >= 80) {
    grade = 'B 良好 (Good)';
  } else if (score >= 70) {
    grade = 'C 合格 (Passable)';
  } else if (score >= 60) {
    grade = 'D 警告 (Warning)';
  } else {
    grade = 'F 失败 (Failed)';
  }

  final totalGroupDurationMs = groups.values.fold<double>(
      0, (sum, g) => sum + g.durationMs);

  return {
    'generated_at': DateTime.now().toIso8601String(),
    'score': score,
    'grade': grade,
    'total_groups': groups.length,
    'passed_groups': groups.length - failures.length,
    'failed_groups': failures.length,
    'failed_group_names': failures,
    'total_metrics': allMetrics.length,
    'high_regressions': highRegressions,
    'warn_count': warnCount,
    'info_count': infoCount,
    'total_duration_ms': totalGroupDurationMs,
    'per_category_metric_count': {
      for (final e in perCategory.entries) e.key: e.value.length
    },
    'all_metrics': allMetrics,
    'group_summary': {
      for (final g in groups.entries)
        g.key: {
          'file': g.value.file,
          'passed': g.value.passed,
          'duration_ms': g.value.durationMs,
          'test_count': g.value.testCount,
          'metrics_count': g.value.metrics.length,
        }
    },
  };
}

void _printConsoleReport(Map<String, dynamic> overall,
    Map<String, _GroupResult> groups) {
  print('\n\x1B[1m═══════════════════════════════════════════════════════════════\x1B[0m');
  print('\x1B[1m📋 CI 综合测试最终报告\x1B[0m');
  print('═══════════════════════════════════════════════════════════════');
  final score = overall['score'];
  final grade = overall['grade'];
  final failed = overall['failed_groups'];
  final totalMs = overall['total_duration_ms'] as double;
  print('  综合得分: \x1B[33m$score / 100\x1B[0m');
  print('  性能评级: \x1B[32m$grade\x1B[0m');
  print('  测试分组: ${overall['passed_groups']} 通过 / ${overall['total_groups']} 总组数 '
      '($failed 失败)');
  print('  总运行时长: ${totalMs.toStringAsFixed(1)} ms');
  print('  采集指标: ${overall['total_metrics']} 个 '
      '(高危:${overall['high_regressions']}  警告:${overall['warn_count']}  正常:${overall['info_count']})');
  print('');
  for (final g in groups.entries) {
    final statusIcon = g.value.passed ? '\x1B[32m✔\x1B[0m' : '\x1B[31m✖\x1B[0m';
    print('   $statusIcon ${g.value.name.padRight(34)}  '
        '${g.value.durationMs.toStringAsFixed(0).padLeft(6)} ms   '
        'metrics: ${g.value.metrics.length.toString().padLeft(3)}');
  }
  if (failed > 0) {
    print('\n  \x1B[31m失败组: ${overall['failed_group_names'].join(', ')}\x1B[0m');
  }
  print('═══════════════════════════════════════════════════════════════');
}

String _renderMarkdown(Map<String, dynamic> overall,
    Map<String, _GroupResult> groups) {
  final score = overall['score'] as int;
  final grade = overall['grade'] as String;
  final failed = overall['failed_groups'] as int;
  final badge = score >= 85
      ? '🟢'
      : score >= 70
          ? '🟡'
          : '🔴';

  final buf = StringBuffer();
  buf.writeln('$badge Flutter 端到端综合 CI 测试报告');
  buf.writeln('');
  buf.writeln('> 报告生成时间: `${overall['generated_at']}`');
  buf.writeln('');
  buf.writeln('### 📊 总览');
  buf.writeln('| 项目 | 结果 |');
  buf.writeln('| :--- | :--- |');
  buf.writeln('| **综合得分** | **$score / 100** |');
  buf.writeln('| **性能评级** | $badge $grade |');
  buf.writeln('| **测试分组通过** | `${overall['passed_groups']} / ${overall['total_groups']}` |');
  buf.writeln('| **失败分组** | `${overall['failed_group_names']}` |');
  buf.writeln('| **总运行时长** | `${(overall['total_duration_ms'] as double).toStringAsFixed(1)} ms` |');
  buf.writeln('| **采集指标数** | `${overall['total_metrics']}` (高危 `${overall['high_regressions']}` / 警告 `${overall['warn_count']}` / 正常 `${overall['info_count']}`) |');
  buf.writeln('');

  buf.writeln('### 📁 分组执行明细');
  buf.writeln('| 分组 | 文件 | 耗时 | 通过 | 测试数 | 指标数 |');
  buf.writeln('| :--- | :--- | ---: | :---: | ---: | ---: |');
  for (final g in groups.entries) {
    final icon = g.value.passed ? '✅' : '❌';
    buf.writeln(
        '| `${g.key}` | `${g.value.file}` | ${g.value.durationMs.toStringAsFixed(0)} ms | $icon | ${g.value.testCount} | ${g.value.metrics.length} |');
  }
  buf.writeln('');

  // Render metrics by category
  final metrics = overall['all_metrics'] as List;
  final byCat = <String, List<dynamic>>{};
  for (final m in metrics) {
    final cat = (m as Map<String, dynamic>)['category'] as String? ?? 'OTHER';
    byCat.putIfAbsent(cat, () => []).add(m);
  }

  for (final e in byCat.entries) {
    buf.writeln('### 🔍 ${_categoryEmoji(e.key)} ${_categoryLabel(e.key)} 指标 (${e.value.length})');
    buf.writeln('| 指标名称 | 数值 | 单位 | 阈值(硬) | 阈值(警告) | 评定 |');
    buf.writeln('| :--- | ---: | :--- | ---: | ---: | :---: |');
    for (final raw in e.value) {
      final m = raw as Map<String, dynamic>;
      final name = (m['metric'] ?? '').toString();
      final val = m['value'] ?? m['total_ms'] ?? m['elapsed_ms'] ?? m['mount_ms'] ?? '-';
      final unit = (m['unit'] ?? '').toString();
      final hard = m['threshold_hard'] as num?;
      final warn = m['threshold_warn'] as num?;
      String status = '✅';
      if (val is num) {
        if (hard != null && val > hard) status = '🔴';
        else if (warn != null && val > warn) status = '🟡';
      }
      buf.writeln(
          '| `$name` | $val | $unit | ${hard ?? '-'} | ${warn ?? '-'} | $status |');
    }
    buf.writeln('');
  }

  buf.writeln('---');
  buf.writeln(
      '_本报告由 tool/ci_test_runner.dart 独立执行, 未修改主应用 `lib/` 目录下任何源码。测试文件位于 `test/ci/`。_');
  return buf.toString();
}

String _categoryEmoji(String cat) {
  switch (cat) {
    case 'UI':
      return '🎨';
    case 'PROVIDER':
      return '📦';
    case 'SERVICE':
      return '⚙️';
    case 'PERF':
      return '⚡';
    case 'MEMORY':
      return '🧠';
    default:
      return '📌';
  }
}

String _categoryLabel(String cat) {
  switch (cat) {
    case 'UI':
      return 'UI / Widget 渲染';
    case 'PROVIDER':
      return 'Riverpod Provider 生命周期';
    case 'SERVICE':
      return '业务服务 / 工具逻辑';
    case 'PERF':
      return '性能与卡顿回归';
    case 'MEMORY':
      return '内存与 GC 压力';
    default:
      return '其他';
  }
}

class _GroupResult {
  final String name;
  final String file;
  final double durationMs;
  final bool passed;
  final int exitCode;
  final int testCount;
  final List<Map<String, dynamic>> metrics;

  _GroupResult({
    required this.name,
    required this.file,
    required this.durationMs,
    required this.passed,
    required this.exitCode,
    required this.testCount,
    required this.metrics,
  });
}
