import 'dart:convert';
import 'dart:typed_data';

class Base64 {
  static String encode(List<int> bytes) {
    return base64.encode(Uint8List.fromList(bytes));
  }

  static List<int> decode(String base64String) {
    return base64.decode(base64String) as List<int>;
  }
}
