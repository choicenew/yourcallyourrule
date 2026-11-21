import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/features/language/services/locale_service.dart';

part 'language_provider.g.dart';

@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Future<Locale> build() async {
    final localeService = ref.watch(localeServiceProvider);
    final savedConfig = await localeService.loadConfig();

    return savedConfig?.locale ?? const Locale('en', 'US');
  }

  Future<void> updateLocale(Locale newLocale) async {
    final localeService = ref.read(localeServiceProvider);
    state = AsyncValue.data(newLocale);
    await localeService.saveConfig(newLocale.languageCode, newLocale.countryCode);
  }
}
