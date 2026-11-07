import 'package:pyro_worker_protocol/pyro_worker_protocol.dart';

/// 纯计算任务：清洗抓取回来的元数据（去除 HTML 标签、多余空格等）
class MetadataCleanerTask
    extends WorkerTask<Map<String, dynamic>, Map<String, dynamic>> {
  const MetadataCleanerTask() : super(taskName: 'MetadataCleanerTask');

  @override
  Map<String, dynamic> execute(Map<String, dynamic> input) {
    final result = Map<String, dynamic>.from(input);

    // 清洗 description
    if (result['description'] is String) {
      result['description'] = _cleanHtml(result['description'] as String);
    }

    // 清洗 title
    if (result['title'] is String) {
      result['title'] = (result['title'] as String).trim();
    }

    return result;
  }

  String _cleanHtml(String html) {
    final regExp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return html.replaceAll(regExp, '').trim();
  }
}
