import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Verification Test for Truecaller API Keys
/// Found in `plugins/apikey`

void main() {
  // Test Data
  const String testNumber = '12026307992'; // Using a generic number (without +)
  const String countryCode = 'US'; // or IN as per one of the snippets

  // Keys to Test
  final Map<String, String> keysToTest = {
    'Key_From_Flask (a2i0a...)': 'a2i0a--xGEup3VdVkAZ5pEdGVr36IAiYoER_c8qIN5GftDqpn5ENRfvJ17vDX70U',
    'Key_From_Kotlin (a1i1V...)': 'a1i1V--ua298eldF0hb0rL520GjDz7bzVAdt63J2nzZBnWlEKNCJUeln_7kWj4Ir',
  };

  // API Configuration (Based on plugins/apikey & truecaller_api.js)
  // URL: https://search5-noneu.truecaller.com/v2/search?q={num}&countryCode={cc}&type=4&encoding=json
  const String baseUrl = 'https://search5-noneu.truecaller.com/v2/search';

  test('Verify Truecaller API Keys Validity', () async {
    print('--- Starting Truecaller API Key Verification ---');

    for (var entry in keysToTest.entries) {
      final keyName = entry.key;
      final token = entry.value;
      
      print('\nTesting $keyName...');
      print('Token: ${token.substring(0, 10)}...'); 

      final queryUrl = Uri.parse('$baseUrl?q=$testNumber&countryCode=$countryCode&type=4&encoding=json');
      
      try {
        final response = await http.get(
          queryUrl,
          headers: {
            'User-Agent': 'Truecaller/15.32.6 (Android;14)', // Mimic App UA from snippet
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Accept-Encoding': 'gzip', // Let Dart http handle decompression if possible, or usually it handles plain identity
            // Note: Dart http client automatically handles gzip if server sends proper content-encoding
          },
        );

        print('  Status Code: ${response.statusCode}');
        
        if (response.statusCode == 200) {
          print('  ✅ KEY IS VALID!');
          // Try parsing body to be sure
          try {
             final json = jsonDecode(response.body);
             final data = json['data'];
             if (data != null && (data as List).isNotEmpty) {
                print('     Data received successfully.');
                print('     Name: ${data[0]['name']}');
             } else {
                print('     Response valid but no data found for this number.');
             }
          } catch (e) {
             print('     (Body not JSON? ${response.body.substring(0, 50)})');
          }

        } else if (response.statusCode == 401) {
          print('  ❌ KEY EXPIRED or INVALID (401 Unauthorized)');
        } else if (response.statusCode == 429) {
          print('  ⚠️ KEY RATE LIMITED (429 Too Many Requests)');
        } else {
           print('  ❌ FAILED with status ${response.statusCode}');
           print('     Body: ${response.body}');
        }

      } catch (e) {
        print('  ❌ CONNECTION ERROR: $e');
      }
    }
    
    print('\n--- Verification Test Finished ---');
  });
}
