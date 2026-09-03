import 'dart:convert';
import 'dart:io';

/// 性能归因实体（量化组件耗时与根因定位）
class RootCause {
  final String id;
  final String severity; // HIGH, MEDIUM, LOW, INFO
  final String name;
  final String blamedComponent;
  final double costMs;
  final String reason;
  final String suggestion;

  RootCause({
    required this.id,
    required this.severity,
    required this.name,
    required this.blamedComponent,
    required this.costMs,
    required this.reason,
    required this.suggestion,
  });

  factory RootCause.fromJson(Map<String, dynamic> j) {
    return RootCause(
      id: j['id']?.toString() ?? 'unknown-cause',
      severity: j['severity']?.toString() ?? 'MEDIUM',
      name: j['name']?.toString() ?? 'Unnamed Issue',
      blamedComponent: j['blamed_component']?.toString() ?? 'lib/unknown',
      costMs: (j['cost_ms'] as num?)?.toDouble() ?? 0.0,
      reason: j['reason']?.toString() ?? '',
      suggestion: j['suggestion']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'severity': severity,
        'name': name,
        'blamed_component': blamedComponent,
        'cost_ms': costMs,
        'reason': reason,
        'suggestion': suggestion,
      };
}

/// 真实实测指标行
class MetricRow {
  final String phase;
  final String metric;
  final double value;
  final String unit;
  final String verdict; // PASS, WARN, FAIL
  final double? thresholdHard;
  final double? thresholdWarn;
  final Map<String, dynamic> raw;

  MetricRow({
    required this.phase,
    required this.metric,
    required this.value,
    required this.unit,
    required this.verdict,
    this.thresholdHard,
    this.thresholdWarn,
    required this.raw,
  });

  factory MetricRow.fromJson(Map<String, dynamic> j) {
    final v = (j['value'] as num?)?.toDouble() ?? 0.0;
    final thHard = (j['threshold_hard'] as num?)?.toDouble();
    final thWarn = (j['threshold_warn'] as num?)?.toDouble();

    String verdict = 'PASS';
    if (thHard != null && v >= thHard) {
      verdict = 'FAIL';
    } else if (thWarn != null && v >= thWarn) {
      verdict = 'WARN';
    }

    return MetricRow(
      phase: j['phase']?.toString() ?? 'unknown',
      metric: j['metric']?.toString() ?? 'unnamed',
      value: v,
      unit: j['unit']?.toString() ?? '',
      verdict: verdict,
      thresholdHard: thHard,
      thresholdWarn: thWarn,
      raw: j,
    );
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

/// 综合性能诊断报告
class ComprehensiveReport {
  final String generatedAt;
  final int highCount;
  final int mediumCount;
  final int lowCount;
  final List<RootCause> sortedCauses;
  final List<MetricRow> metrics;
  final double weightedScore;
  final String grade;

  ComprehensiveReport._({
    required this.generatedAt,
    required this.highCount,
    required this.mediumCount,
    required this.lowCount,
    required this.sortedCauses,
    required this.metrics,
    required this.weightedScore,
    required this.grade,
  });

  factory ComprehensiveReport.create({
    required List<RootCause> causes,
    required List<MetricRow> metrics,
  }) {
    final sortedCauses = List<RootCause>.from(causes)
      ..sort((a, b) => b.costMs.compareTo(a.costMs));

    final highCount = sortedCauses.where((c) => c.severity == 'HIGH').length;
    final mediumCount = sortedCauses.where((c) => c.severity == 'MEDIUM').length;
    final lowCount = sortedCauses.where((c) => c.severity == 'LOW').length;

    double s = 100.0 - (highCount * 30.0) - (mediumCount * 10.0) - (lowCount * 2.0);
    if (s < 0) s = 0.0;

    String g;
    if (s >= 90) {
      g = 'A (优秀)';
    } else if (s >= 80) {
      g = 'B (良好)';
    } else if (s >= 70) {
      g = 'C (中等)';
    } else if (s >= 60) {
      g = 'D (及格)';
    } else {
      g = 'F (极差需优化)';
    }

    return ComprehensiveReport._(
      generatedAt: DateTime.now().toUtc().toIso8601String(),
      highCount: highCount,
      mediumCount: mediumCount,
      lowCount: lowCount,
      sortedCauses: sortedCauses,
      metrics: metrics,
      weightedScore: s,
      grade: g,
    );
  }

  String toMarkdown() {
    final sb = StringBuffer();
    sb.writeln('# 📱 Flutter 全性能与系统矩阵 CI 综合诊断报告');
    sb.writeln();
    sb.writeln('- **测试生成时间**: `$generatedAt`');
    sb.writeln('- **综合体验得分**: **${weightedScore.toStringAsFixed(1)} / 100** (等级: **$grade**)');
    sb.writeln('- **归因瓶颈总计**: 高危 **$highCount** | 警告 **$mediumCount** | 轻微 **$lowCount**');
    sb.writeln('- **采集指标总数**: `${metrics.length}`');
    sb.writeln();

    // 1. 拖慢 App 核心瓶颈归因排行榜
    if (sortedCauses.isNotEmpty) {
      sb.writeln('## 🚨 拖慢 App 体验与跟手度的瓶颈排行榜 (Top Slowdowns)');
      sb.writeln();
      sb.writeln('| 严重度 | 问题描述 | 责任组件 / 模块 | 影响耗时 | 根因机理解释 | 优化建议 |');
      sb.writeln('| :---: | :--- | :--- | :---: | :--- | :--- |');
      for (final c in sortedCauses) {
        final icon = c.severity == 'HIGH' ? '🔴 HIGH' : (c.severity == 'MEDIUM' ? '🟡 MEDIUM' : '🟢 LOW');
        sb.writeln('| $icon | **${c.name}** | `${c.blamedComponent}` | **${c.costMs.toStringAsFixed(1)} ms** | ${c.reason} | ${c.suggestion} |');
      }
      sb.writeln();
    }

    // 2. 真实测量指标详情表
    final sortedMetrics = List<MetricRow>.from(metrics)
      ..sort((a, b) => b.value.compareTo(a.value));

    sb.writeln('## ⏱️ 全链路性能与跟手度实测指标明细');
    sb.writeln();
    sb.writeln('| 阶段 / 模块 | 测量项 | 实测数值 | 预算标准 | 评定 |');
    sb.writeln('| :--- | :--- | :---: | :---: | :---: |');
    for (final m in sortedMetrics) {
      final thStr = m.thresholdHard != null ? '<= ${m.thresholdHard} ${m.unit}' : '-';
      final status = m.verdict == 'FAIL' ? '❌ FAIL' : (m.verdict == 'WARN' ? '⚠️ WARN' : '✅ PASS');
      sb.writeln('| `${m.phase}` | `${m.metric}` | **${m.value.toStringAsFixed(2)} ${m.unit}** | $thStr | $status |');
    }
    sb.writeln();

    return sb.toString();
  }
}

void main(List<String> args) {
  final reportsDir = Directory('ci_reports');
  if (!reportsDir.existsSync()) {
    reportsDir.createSync(recursive: true);
  }

  final causes = <RootCause>[];
  final metrics = <MetricRow>[];

  // 1. 扫描所有的指标与根因 jsonl 文件
  final jsonlFiles = reportsDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.jsonl'));

  for (final file in jsonlFiles) {
    try {
      for (final line in file.readAsLinesSync()) {
        final t = line.trim();
        if (t.isEmpty || !t.startsWith('{')) continue;
        try {
          final j = jsonDecode(t);
          if (j is Map<String, dynamic>) {
            if (j.containsKey('id') && j.containsKey('blamed_component')) {
              causes.add(RootCause.fromJson(j));
            } else if (j.containsKey('value') && j.containsKey('metric')) {
              metrics.add(MetricRow.fromJson(j));
            }
          }
        } catch (_) {}
      }
    } catch (_) {}
  }

  // 2. 扫描 .log 文件中输出的 ROOT_CAUSE 和 METRIC
  final logFiles = reportsDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.log'));

  for (final file in logFiles) {
    try {
      for (final line in file.readAsLinesSync()) {
        if (line.contains('ROOT_CAUSE:')) {
          final payload = line.split('ROOT_CAUSE:').last.trim();
          try {
            causes.add(RootCause.fromJson(jsonDecode(payload)));
          } catch (_) {}
        } else if (line.contains('_METRIC:')) {
          final payload = line.split(RegExp(r'[A-Za-z0-9_]+_METRIC:')).last.trim();
          try {
            metrics.add(MetricRow.fromJson(jsonDecode(payload)));
          } catch (_) {}
        }
      }
    } catch (_) {}
  }

  // 去重
  final uniqueCauses = <String, RootCause>{};
  for (final c in causes) {
    uniqueCauses[c.id] = c;
  }

  final report = ComprehensiveReport.create(
    causes: uniqueCauses.values.toList(),
    metrics: metrics,
  );

  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final mdFile = File('ci_reports/ci_root_cause_report_$timestamp.md');
  final jsonFile = File('ci_reports/ci_root_cause_report_$timestamp.json');

  mdFile.writeAsStringSync(report.toMarkdown());
  jsonFile.writeAsStringSync(jsonEncode({
    'generated_at': report.generatedAt,
    'score': report.weightedScore,
    'grade': report.grade,
    'high_count': report.highCount,
    'medium_count': report.mediumCount,
    'low_count': report.lowCount,
    'causes': report.sortedCauses.map((c) => c.toJson()).toList(),
    'metrics': report.metrics.map((m) => m.toJson()).toList(),
  }));

  stdout.writeln('=== CI 性能综合报告已生成 ===');
  stdout.writeln('综合得分: ${report.weightedScore.toStringAsFixed(1)} / 100 (${report.grade})');
  stdout.writeln('发现瓶颈: ${report.sortedCauses.length} 项 (高危: ${report.highCount})');
  stdout.writeln('采集指标: ${report.metrics.length} 项');
  stdout.writeln('报告文件: ${mdFile.path}');
}
