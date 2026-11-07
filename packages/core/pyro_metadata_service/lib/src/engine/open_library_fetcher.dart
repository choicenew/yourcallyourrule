import 'dart:convert';
import 'package:http/http.dart' as http;

/// OpenLibrary ISBN 与条形码图书元数据抓取引擎
/// 参考 Openreads 开源项目实施对标，支持通过 ISBN 或条形码自动抓取书名、作者、出版商、封面及出版年份
class OpenLibraryMetadataFetcher {
  final http.Client _client;

  OpenLibraryMetadataFetcher({http.Client? client})
      : _client = client ?? http.Client();

  /// 根据 ISBN 抓取完整的 OpenLibrary 图书元数据
  Future<Map<String, dynamic>?> fetchByIsbn(String isbn) async {
    final cleanIsbn = isbn.replaceAll(RegExp(r'[^0-9X]'), '');
    if (cleanIsbn.isEmpty) return null;

    try {
      final uri = Uri.parse(
        'https://openlibrary.org/api/books?bibkeys=ISBN:$cleanIsbn&format=json&jscmd=data',
      );
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final map = json.decode(response.body) as Map<String, dynamic>;
        final bookKey = 'ISBN:$cleanIsbn';
        if (map.containsKey(bookKey)) {
          final data = map[bookKey] as Map<String, dynamic>;
          final authors = (data['authors'] as List?)
                  ?.map((a) => (a as Map)['name']?.toString() ?? '')
                  .where((s) => s.isNotEmpty)
                  .join(', ') ??
              '';

          final coverMap = data['cover'] as Map<String, dynamic>?;
          final coverUrl = coverMap?['large'] ?? coverMap?['medium'] ?? coverMap?['small'] ?? '';

          return {
            'title': data['title'] ?? '',
            'author': authors,
            'publisher': (data['publishers'] as List?)?.first?['name'] ?? '',
            'publishDate': data['publish_date'] ?? '',
            'coverUrl': coverUrl,
            'numberOfPages': data['number_of_pages'],
            'isbn': cleanIsbn,
            'source': 'OpenLibrary',
          };
        }
      }
    } catch (_) {}
    return null;
  }
}
