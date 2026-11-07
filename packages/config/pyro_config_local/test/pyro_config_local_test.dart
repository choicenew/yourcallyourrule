import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_config_local/pyro_config_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('SharedPreferencesConfigRepository Tests', () {
    test('saveConfig and getConfig work correctly with automatic key indexing', () async {
      final repo = SharedPreferencesConfigRepository();

      await repo.saveConfig('pyro_theme_mode', {'mode': 1});
      await repo.saveConfig('pyro_l10n_locale', {'language': 'zh_CN'});
      await repo.saveConfig('pyro_viewer_manga_contrast', {'contrast': 1.2});
      await repo.saveConfig('pyro_viewer_txt_font_size', {'fontSize': 18});
      await repo.saveConfig('pyro_shelf_layout_mode', {'mode': 'grid'});
      await repo.saveConfig('pyro_pomodoro_focus_duration_minutes', {'minutes': 25});
      await repo.saveConfig('pyro_flashcard_daily_review_limit', {'limit': 50});
      await repo.saveConfig('config_user_profile', {'name': 'Alice'});

      final themeConfig = await repo.getConfig('pyro_theme_mode');
      expect(themeConfig, equals({'mode': 1}));

      final mangaConfig = await repo.getConfig('pyro_viewer_manga_contrast');
      expect(mangaConfig, equals({'contrast': 1.2}));

      final allKeys = await repo.getAllKeys();
      expect(allKeys, contains('pyro_theme_mode'));
      expect(allKeys, contains('pyro_l10n_locale'));
      expect(allKeys, contains('pyro_viewer_manga_contrast'));
      expect(allKeys, contains('pyro_viewer_txt_font_size'));
      expect(allKeys, contains('pyro_shelf_layout_mode'));
      expect(allKeys, contains('pyro_pomodoro_focus_duration_minutes'));
      expect(allKeys, contains('pyro_flashcard_daily_review_limit'));
      expect(allKeys, contains('config_user_profile'));
    });

    test('removeConfig removes item and updates key index', () async {
      final repo = SharedPreferencesConfigRepository();

      await repo.saveConfig('config_temp_setting', {'enabled': true});
      expect(await repo.getConfig('config_temp_setting'), isNotNull);

      await repo.removeConfig('config_temp_setting');
      expect(await repo.getConfig('config_temp_setting'), isNull);

      final allKeys = await repo.getAllKeys();
      expect(allKeys, isNot(contains('config_temp_setting')));
    });
  });

  group('ConfigCloudConverter Payload Decoupling Tests', () {
    test('convertToCloudFormat exports clean plain Map including reader and tools preferences', () async {
      final repo = SharedPreferencesConfigRepository();
      final converter = ConfigCloudConverter(repo);

      await repo.saveConfig('pyro_theme_flex_scheme', {'scheme': 'sakura'});
      await repo.saveConfig('pyro_l10n_regional_locale', {'region': 'zh_CN'});
      await repo.saveConfig('pyro_viewer_manga_spread_mode', {'mode': 'autoLandscapeSpread'});
      await repo.saveConfig('pyro_shelf_sort_order', {'sort': 'last_read'});

      final payload = await converter.convertToCloudFormat();

      expect(payload['type'], equals('config_backup'));
      expect(payload['version'], equals(1));
      expect(payload['data'], isA<Map<String, dynamic>>());

      final dataMap = payload['data'] as Map<String, dynamic>;
      expect(dataMap, contains('pyro_theme_flex_scheme'));
      expect(dataMap, contains('pyro_l10n_regional_locale'));
      expect(dataMap, contains('pyro_viewer_manga_spread_mode'));
      expect(dataMap, contains('pyro_shelf_sort_order'));
    });

    test('restoreFromCloudFormat restores map entries into ConfigRepository', () async {
      final repo = SharedPreferencesConfigRepository();
      final converter = ConfigCloudConverter(repo);

      final mockCloudPayload = {
        'type': 'config_backup',
        'version': 1,
        'timestamp': 1728042000000,
        'data': {
          'pyro_theme_is_high_contrast': {'enabled': true},
          'pyro_l10n_locale': {'code': 'en_US'},
          'pyro_viewer_txt_page_turn_style': {'style': 'curl'},
          'pyro_pomodoro_focus_duration_minutes': {'minutes': 30},
        },
      };

      await converter.restoreFromCloudFormat(mockCloudPayload);

      final restoredTheme = await repo.getConfig('pyro_theme_is_high_contrast');
      expect(restoredTheme, equals({'enabled': true}));

      final restoredTxt = await repo.getConfig('pyro_viewer_txt_page_turn_style');
      expect(restoredTxt, equals({'style': 'curl'}));

      final restoredPomodoro = await repo.getConfig('pyro_pomodoro_focus_duration_minutes');
      expect(restoredPomodoro, equals({'minutes': 30}));
    });
  });
}
