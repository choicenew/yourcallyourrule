import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Test Mobile UA Papago API', () async {
    const mobileUa =
        'Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Mobile Safari/537.36';

    print('Testing Papago with Mobile UA...');
    final resp = await http.post(
      Uri.parse('https://papago.naver.com/apis/n2mt/translate'),
      headers: {
        'User-Agent': mobileUa,
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Origin': 'https://papago.naver.com',
        'Referer': 'https://papago.naver.com/',
      },
      body: {
        'source': 'en',
        'target': 'zh-CN',
        'text': 'Hello world',
      },
    );

    print('Mobile UA Status: ${resp.statusCode}');
    print('Mobile UA Body: ${resp.body}');
  });
}
