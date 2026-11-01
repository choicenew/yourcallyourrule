import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

/// Real HTTP downloader for external feed files (OpenPhish feed.txt, PhishTank feeds, etc.)
class FeedDownloader {
  final HttpClient _client;

  FeedDownloader({HttpClient? client}) : _client = client ?? HttpClient();

  /// Download plain text feed file from raw URL (e.g. OpenPhish feed.txt)
  Future<String> downloadTextFeed(String url) async {
    try {
      final uri = Uri.parse(url);
      final request = await _client.getUrl(uri);
      final response = await request.close();

      if (response.statusCode == 200) {
        final content = await response.transform(utf8.decoder).join();
        return content;
      } else {
        debugPrint('[FeedDownloader] HTTP error ${response.statusCode} for $url');
        return '';
      }
    } catch (e) {
      debugPrint('[FeedDownloader] Failed downloading feed $url: $e');
      return '';
    }
  }
}
