import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/setup_config.dart';

/// 负责从云端拉取 Initial Setup 页面所需的动态配置
class InitialSetupService {
  final String configUrl;

  InitialSetupService(this.configUrl);

  Future<SetupConfig> fetchConfig() async {
    try {
      final response = await http.get(Uri.parse(configUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SetupConfig.fromMap(data);
      } else {
        throw Exception('HTTP Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('获取初始配置失败: $e');
    }
  }
}
