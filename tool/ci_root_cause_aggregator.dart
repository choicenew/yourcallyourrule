import 'dart:convert';
import 'dart:io';

const _severityOrder = <String, int>{'HIGH': 0, 'MEDIUM': 1, 'LOW': 2};

String _pad(String s, int w, {bool left = false}) {
  if (s.length >= w) return s.substring(0, w);
  final pad = ' ' * (w - s.length);
  return left ? '$pad$s' : '$s$pad';
}

class RootCause implements Comparable<RootCause> {
  final String id;
  final String severity;
  final String name;
  final String blamedComponent;
  final double costMs;
  final String reason;
  final String suggestion;
  final Map<String, dynamic> raw;

  RootCause({
    required this.id,
    required this.severity,
    required this.name,
    required this.blamedComponent,
    required this.costMs,
    required this.reason,
    required this.suggestion,
    required this.raw,
  });

  @override
  int compareTo(RootCause other) {
    final sa = _severityOrder[severity] ?? 99;
    final sb = _severityOrder[other.severity] ?? 99;
    if (sa != sb) return sa.compareTo(sb);
    return other.costMs.compareTo(costMs);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'severity': severity,
        'name': name,
        'blamed_component': blamedComponent,
        'cost_ms': costMs,
        'reason': reason,
        'suggestion': suggestion,
        'raw': raw,
      };
}

class MetricRow {
  final String phase;
  final String metric;
  final double value;
  final String unit;
  final double? thresholdHard;
  final double? thresholdWarn;
  final Map<String, dynamic> raw;

  MetricRow({
    required this.phase,
    required this.metric,
    required this.value,
    required this.unit,
    this.thresholdHard,
    this.thresholdWarn,
    required this.raw,
  });

  String get verdict {
    if (thresholdHard != null && value >= thresholdHard!) return 'HARD_FAIL';
    if (thresholdWarn != null && value >= thresholdWarn!) return 'WARN';
    return 'OK';
  }

  Map<String, dynamic> toJson() => {
        'phase': phase,
        'metric': metric,
        'value': value,
        'unit': unit,
        'verdict': verdict,
        'threshold_hard': thresholdHard,
        'threshold_warn': thresholdWarn,
        'raw': raw,
      };
}

class Report {
  final String generatedAt;
  final int highCount;
  final int mediumCount;
  final int lowCount;
  final List<RootCause> sortedCauses;
  final List<MetricRow> metrics;
  final double weightedScore; // 0..100, higher better
  final String grade; // A..F

  Report({
    required this.generatedAt,
    required this.sortedCauses,
    required this.metrics,
  })  : highCount = sortedCauses.where((c) => c.severity == 'HIGH').length,
        mediumCount = sortedCauses.where((c) => c.severity == 'MEDIUM').length,
        lowCount = sortedCauses.where((c) => c.severity == 'LOW').length,
        weightedScore = () {
          final h = sortedCauses.where((c) => c.severity == 'HIGH').length;
          final m = sortedCauses.where((c) => c.severity == 'MEDIUM').length;
          final l = sortedCauses.where((c) => c.severity == 'LOW').length;
          double s = 100.0;
          s -= h * 35.0;
          s -= m * 10.0;
          s -= l * 2.0;
          if (s < 0) s = 0;
          return s;
        }(),
        grade = () {
          final h = sortedCauses.where((c) => c.severity == 'HIGH').length;
          final m = sortedCauses.where((c) => c.severity == 'MEDIUM').length;
          final l = sortedCauses.where((c) => c.severity == 'LOW').length;
          double s = 100.0;
          s -= h * 35.0;
          s -= m * 10.0;
          s -= l * 2.0;
          if (s < 0) s = 0;
          if (s >= 90) return 'A';
          if (s >= 80) return 'B';
          if (s >= 70) return 'C';
          if (s >= 60) return 'D';
          if (s >= 40) return 'E';
          return 'F';
        }();
}

List<RootCause> _loadRootCauses(File f) {
  if (!f.existsSync()) return const [];
  final out = <RootCause>[];
  for (final line in f.readAsLinesSync()) {
    final l = line.trim();
    if (l.isEmpty) continue;
    try {
      final d = jsonDecode(l) as Map<String, dynamic>;
      out.add(RootCause(
        id: d['id']?.toString() ?? 'id-${out.length}',
        severity: d['severity']?.toString().toUpperCase() ?? 'MEDIUM',
        name: d['name']?.toString() ?? '(unnamed)',
        blamedComponent:
            d['blamed_component']?.toString() ?? d['blame_component']?.toString() ?? '(unknown)',
        costMs: _toDouble(d['cost_ms']) ?? _toDouble(d['costMs']) ?? 0.0,
        reason: d['reason']?.toString() ?? '(no reason)',
        suggestion: d['suggestion']?.toString() ?? '(no suggestion)',
        raw: d,
      ));
    } catch (_) {
      // skip malformed
    }
  }
  return out;
}

double? _toDouble(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}

List<MetricRow> _loadMetrics(File f) {
  if (!f.existsSync()) return const [];
  final out = <MetricRow>[];
  for (final line in f.readAsLinesSync()) {
    final l = line.trim();
    if (l.isEmpty) continue;
    try {
      final d = jsonDecode(l) as Map<String, dynamic>;
      final value = _toDouble(d['value']);
      if (value == null) continue;
      out.add(MetricRow(
        phase: d['phase']?.toString() ?? 'unknown',
        metric: d['metric']?.toString() ?? 'unknown',
        value: value,
        unit: d['unit']?.toString() ?? 'n/a',
        thresholdHard: _toDouble(d['threshold_hard'] ?? d['thresholdHard']),
        thresholdWarn: _toDouble(d['threshold_warn'] ?? d['thresholdWarn']),
        raw: d,
      ));
    } catch (_) {
      // skip malformed
    }
  }
  return out;
}

String _escapeMdCell(String s) =>
    s.replaceAll('|', r'\|').replaceAll('\n', ' ').trim();

String _renderMarkdown(Report r) {
  final lines = <String>[];
  lines.add('# 综合性能根因分析 · 谁拖慢了 App');
  lines.add('');
  lines.add('> 生成于 `${r.generatedAt}` | 样本: **${r.metrics.length} 项指标** | **${r.sortedCauses.length} 个根因**');
  lines.add('');
  lines.add('## 🎯 总体评分: **$r.grade** · ${r.weightedScore.toStringAsFixed(1)} / 100');
  lines.add('');
  lines.add('| 严重度 | 数量 |');
  lines.add('|---|---:|');
  lines.add('| 🔴 HIGH (阻塞级) | ${r.highCount} |');
  lines.add('| 🟠 MEDIUM (需优化) | ${r.mediumCount} |');
  lines.add('| 🟡 LOW (建议项) | ${r.lowCount} |');
  lines.add('');

  lines.add('## 🏆 Top-N 拖慢者排行榜 (按 严重度 → cost_ms 降序)');
  lines.add('');
  lines.add('| 排名 | 严重度 | 拖慢者组件 (blamed_component) | cost_ms | 名称 / 现象 | 根因分析 | 建议修复 |');
  lines.add('|---|---|---|---:|---|---|---|');
  int rank = 0;
  for (final c in r.sortedCauses) {
    rank++;
    final sevMd = c.severity == 'HIGH'
        ? '🔴 HIGH'
        : c.severity == 'MEDIUM'
            ? '🟠 MEDIUM'
            : '🟡 LOW';
    lines.add(
        '| $rank | $sevMd | `${_escapeMdCell(c.blamedComponent)}` | ${c.costMs.toStringAsFixed(1)} | ${_escapeMdCell(c.name)} | ${_escapeMdCell(c.reason)} | ${_escapeMdCell(c.suggestion)} |');
    if (rank >= 30) break;
  }
  lines.add('');

  lines.add('## 📊 指标总览 (按 phase 分组)');
  lines.add('');
  final byPhase = <String, List<MetricRow>>{};
  for (final m in r.metrics) {
    byPhase.putIfAbsent(m.phase, () => []).add(m);
  }
  for (final e in byPhase.entries) {
    lines.add('### `${e.key}`');
    lines.add('');
    lines.add('| 判决 | 指标 | 值 | 单位 | WARN 阈值 | HARD 阈值 |');
    lines.add('|---|---|---:|---|---:|---:|');
    final rows = e.value
      ..sort((a, b) {
        const order = {'HARD_FAIL': 0, 'WARN': 1, 'OK': 2};
        final oa = order[a.verdict] ?? 99;
        final ob = order[b.verdict] ?? 99;
        if (oa != ob) return oa.compareTo(ob);
        return b.value.compareTo(a.value);
      });
    for (final m in rows) {
      final verdictEmoji = m.verdict == 'HARD_FAIL'
          ? '❌ HARD_FAIL'
          : m.verdict == 'WARN'
              ? '⚠️ WARN'
              : '✅ OK';
      lines.add(
          '| $verdictEmoji | `${m.metric}` | ${m.value.toStringAsFixed(2)} | ${m.unit} | ${m.thresholdWarn?.toStringAsFixed(1) ?? '-'} | ${m.thresholdHard?.toStringAsFixed(1) ?? '-'} |');
    }
    lines.add('');
  }

  return lines.join('\n');
}

String _gradeColor(String g) {
  switch (g) {
    case 'A':
      return 'bright green';
    case 'B':
      return 'green';
    case 'C':
      return 'yellow';
    case 'D':
      return 'yellow orange';
    case 'E':
      return 'red';
    default:
      return 'bright red';
  }
}

void _printConsole(Report r, List<String> args) {
  final w = stdout.hasTerminal ? stdout.terminalColumns : 100;
  final bar = '=' * (w > 120 ? 120 : w);
  print(bar);
  print('🎯 综合性能根因分析  ·  谁拖慢了 App ?');
  print('📅 生成于: ${r.generatedAt}   |   指标 ${r.metrics.length} 条   |   根因 ${r.sortedCauses.length} 个');
  print('📊 总评分: ${r.grade}  (${r.weightedScore.toStringAsFixed(1)} / 100)   '
      '🔴H=${r.highCount}  🟠M=${r.mediumCount}  🟡L=${r.lowCount}');
  print(bar);
  print('');
  const colRank = 5;
  const colSev = 10;
  const colCost = 12;
  const colComp = 36;
  int rest = (w > 160 ? 160 : w) - colRank - colSev - colCost - colComp - 4 * 3 - 5;
  if (rest < 40) rest = 40;
  final colName = (rest * 0.45).round();
  final colReason = (rest * 0.55).round();
  print('| ${_pad('#', colRank, left: true)} | ${_pad('SEV', colSev)} | ${_pad('COST(ms)', colCost, left: true)} | ${_pad('BLAMED COMPONENT', colComp)} | ${_pad('NAME / PHENOMENON', colName)} | ${_pad('REASON', colReason)} |');
  print('| ${'-' * colRank} | ${'-' * colSev} | ${'-' * colCost} | ${'-' * colComp} | ${'-' * colName} | ${'-' * colReason} |');

  int rank = 0;
  for (final c in r.sortedCauses) {
    rank++;
    final sev = c.severity.padRight(4).substring(0, 4);
    print('| ${_pad('$rank', colRank, left: true)} | ${_pad(sev, colSev)} | ${_pad(c.costMs.toStringAsFixed(1), colCost, left: true)} | ${_pad(c.blamedComponent, colComp)} | ${_pad(c.name, colName)} | ${_pad(c.reason, colReason)} |');
    if (rank >= 20) break;
  }
  print('');
  print(bar);
  print('✅ 详细 Markdown 报告 + 完整 JSON 已写入 ci_reports/ 目录。');
  print('   - HIGH_SEVERITY_COUNT = ${r.highCount}  (--fail-high 时据此判定 exit code)');
  if (args.contains('--ci')) {
    print('   - --ci 模式: 已追加报告到 \$GITHUB_STEP_SUMMARY 并写 HIGH_SEVERITY_COUNT 到 \$GITHUB_ENV');
  }
  if (args.contains('--fail-high')) {
    if (r.highCount > 0) {
      print('   - --fail-high + HIGH>0: exit(1)');
    } else {
      print('   - --fail-high + HIGH=0: exit(0)');
    }
  }
  print(bar);
}

Map<String, dynamic> _renderJson(Report r) {
  return {
    'generated_at': r.generatedAt,
    'summary': {
      'grade': r.grade,
      'weighted_score_100': r.weightedScore,
      'high_severity_count': r.highCount,
      'medium_severity_count': r.mediumCount,
      'low_severity_count': r.lowCount,
      'total_root_causes': r.sortedCauses.length,
      'total_metrics': r.metrics.length,
    },
    'root_causes_top_n': r.sortedCauses.take(50).map((c) => c.toJson()).toList(),
    'metrics_verdicts': r.metrics.map((m) => m.toJson()).toList(),
  };
}

void main(List<String> args) async {
  final metricsFile = File('ci_reports/ALL_METRICS.jsonl');
  final causesFile = File('ci_reports/ALL_ROOT_CAUSES.jsonl');
  final metrics = _loadMetrics(metricsFile);
  final causes = _loadRootCauses(causesFile)..sort();
  final now = DateTime.now().toUtc().toIso8601String();
  final stamp = DateTime.now()
      .toUtc()
      .toIso8601String()
      .replaceAll(':', '-')
      .replaceAll('.', '-')
      .replaceAll('T', '_')
      .substring(0, 19);
  Directory('ci_reports').createSync(recursive: true);

  final report = Report(
    generatedAt: now,
    sortedCauses: causes,
    metrics: metrics,
  );

  final mdPath = 'ci_reports/ci_root_cause_report_$stamp.md';
  final jsonPath = 'ci_reports/ci_root_cause_report_$stamp.json';

  File(mdPath).writeAsStringSync(_renderMarkdown(report));
  File(jsonPath)
      .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(_renderJson(report)));

  // 始终写一份 latest 方便下游取文件
  File('ci_reports/ci_root_cause_report_latest.md')
      .writeAsStringSync(_renderMarkdown(report));
  File('ci_reports/ci_root_cause_report_latest.json').writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(_renderJson(report)));

  // CI 模式: 写 GITHUB_ENV / GITHUB_STEP_SUMMARY
  if (args.contains('--ci')) {
    final envFile =
        Platform.environment['GITHUB_ENV'] ?? Platform.environment['GITHUB_OUTPUT'] ?? '';
    if (envFile.isNotEmpty) {
      final f = File(envFile);
      try {
        f.writeAsStringSync(
          'HIGH_SEVERITY_COUNT=${report.highCount}\nMEDIUM_SEVERITY_COUNT=${report.mediumCount}\nLOW_SEVERITY_COUNT=${report.lowCount}\nCI_PERF_GRADE=${report.grade}\nCI_PERF_SCORE=${report.weightedScore.toStringAsFixed(1)}\n',
          mode: FileMode.append,
        );
      } catch (_) {}
    }
    final stepSummary = Platform.environment['GITHUB_STEP_SUMMARY'] ?? '';
    if (stepSummary.isNotEmpty) {
      try {
        File(stepSummary).writeAsStringSync(
          '\n' + File(mdPath).readAsStringSync() + '\n',
          mode: FileMode.append,
        );
      } catch (_) {}
    }
    stdout.writeln(
        'HIGH_SEVERITY_COUNT=${report.highCount}\nMEDIUM_SEVERITY_COUNT=${report.mediumCount}\nLOW_SEVERITY_COUNT=${report.lowCount}\nCI_PERF_GRADE=${report.grade}\nCI_PERF_SCORE=${report.weightedScore.toStringAsFixed(1)}\n');
  }

  _printConsole(report, args);

  exitCode = 0;
  if (args.contains('--fail-high') && report.highCount > 0) {
    exitCode = 1;
  }
}
