import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/features/language/services/locale_service.dart';
import 'package:yourcallyourrule/core/provider/providers/config_repository_provider.dart';

/// LocaleService的Provider
final localeServiceProvider = Provider<LocaleService>((ref) {
  final configRepository = ref.watch(configRepositoryProvider);
  return LocaleService(configRepository);
});