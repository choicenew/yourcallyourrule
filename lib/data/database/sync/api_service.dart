import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static final String _workerUrl = dotenv.get('CF_WORKER_URL');
  static final String _apiSecret = dotenv.get('WORKER_API_SECRET');
  
  const ApiService();

  Future<bool> pushChanges({
    required List<Map<String, dynamic>> changes,
    required String deviceId,
  }) async {
    final response = await http.post(
      Uri.parse('$_workerUrl/sync'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-SECRET': _apiSecret,
      },
      body: jsonEncode({
        'operations': changes,
        'sourceDeviceId': deviceId,
      }),
    );
    return response.statusCode == 200;
  }

  Future<List<Map<String, dynamic>>> getChanges({
    DateTime? since,
    required String deviceId,
  }) async {
    final uri = Uri.parse('$_workerUrl/sync').replace(
      queryParameters: {
        'since': since?.toIso8601String() ?? DateTime.fromMillisecondsSinceEpoch(0).toIso8601String(),
        'deviceId': deviceId,
      },
    );

    final response = await http.get(uri, headers: {'X-API-SECRET': _apiSecret});
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['operations'] ?? []);
    } else {
      throw Exception('Failed to get changes from the API: ${response.statusCode}');
    }
  }
}