import 'dart:convert';
import 'package:http/http.dart' as http;
import 'translation_provider.dart';

class TildeProvider extends TranslationProvider {
  static const _homeUrl = 'https://translate.tilde.com/';
  static const _configUrl =
      'https://translate.tilde.com/assets/config.local.json';
  static const _translateUrl =
      'https://letsmt.eu/ws/service.svc/json/TranslateEx';

  final String _userAgent;
  Map<String, dynamic>? _config;
  String? _clientId;
  String? _appId;
  String? _systemListUrl;

  // Cache of language pairs -> SystemID
  final Map<String, String> _systemIds = {};

  TildeProvider({String? userAgent})
      : _userAgent = userAgent ??
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36';

  Future<void> _ensureInit() async {
    if (_config != null) return;

    try {
      print('Tilde: Fetching config from $_configUrl...');
      final configResp = await http.get(Uri.parse(_configUrl), headers: {
        'User-Agent': _userAgent,
        'Referer': _homeUrl,
      });

      _config = jsonDecode(configResp.body);
      final apiConfig = _config!['mt']['api'];
      _clientId = apiConfig['clientId'];
      _appId = apiConfig['appID'];
      _systemListUrl = apiConfig['systemListUrl'];

      print('Tilde: Config loaded. ClientID: $_clientId');

      // Fetch systems
      print('Tilde: Fetching systems from $_systemListUrl...');
      final systemsResp = await http.get(
          Uri.parse(_systemListUrl!).replace(queryParameters: {
            'appID': _appId,
            'uiLanguageID': 'en' // default
          }),
          headers: {
            'User-Agent': _userAgent,
            'client-id':
                _clientId!, // Header usually lower case keyword in dart? 'client-id'
          });

      final sysData = jsonDecode(systemsResp.body);
      final systems = sysData['System'] as List;

      for (var sys in systems) {
        final src = sys['SourceLanguage']['Code'];
        final tgt = sys['TargetLanguage']['Code'];
        final id = sys['ID'];

        _systemIds['$src-$tgt'] = id;
      }
      print('Tilde: Loaded ${_systemIds.length} systems.');
    } catch (e) {
      print('Tilde: Init failed: $e');
      rethrow;
    }
  }

  @override
  bool get supportsAuto => false;

  @override
  Future<String> translate(String text,
      {required String targetLanguage, String sourceLanguage = 'auto'}) async {
    try {
      await _ensureInit();

      var from = sourceLanguage;
      var to = targetLanguage;

      final pairKey = '$from-$to';
      final systemId = _systemIds[pairKey];

      if (systemId == null) {
        throw Exception('Tilde: No system found for pair $from -> $to');
      }

      final body = {
        'text': text,
        'appID': _appId,
        'systemID': systemId,
        'options': 'widget=text,alignment,markSentences',
      };

      final response = await http.post(
        Uri.parse(_translateUrl),
        headers: {
          'User-Agent': _userAgent,
          'Content-Type': 'application/json',
          'client-id': _clientId!,
          'Origin': _homeUrl,
          'Referer': _homeUrl,
        },
        body: jsonEncode(body),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Tilde API Error (${response.statusCode}): ${response.body}');
      }

      final data = jsonDecode(utf8.decode(response.bodyBytes));

      if (data['translation'] != null) {
        return data['translation'].toString();
      } else {
        throw Exception('Unexpected response format: $data');
      }
    } catch (e) {
      throw Exception('Tilde translation failed: $e');
    }
  }
}
