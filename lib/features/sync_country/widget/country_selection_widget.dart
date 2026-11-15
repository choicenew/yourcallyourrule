import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pyro_phone_country_sync_hub/pyro_phone_country_sync_hub.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class CountrySelectionWidget extends ConsumerStatefulWidget {
  const CountrySelectionWidget({super.key});

  @override
  ConsumerState<CountrySelectionWidget> createState() => _CountrySelectionWidgetState();
}

class _CountrySelectionWidgetState extends ConsumerState<CountrySelectionWidget> {
  String _selectedCountryCode = 'US';
  bool _isDownloading = false;

  static const List<Map<String, String>> _countries = [
    {'code': 'CN', 'name': 'China (中国)', 'flag': '🇨🇳'},
    {'code': 'US', 'name': 'United States (美国)', 'flag': '🇺🇸'},
    {'code': 'GB', 'name': 'United Kingdom (英国)', 'flag': '🇬🇧'},
    {'code': 'JP', 'name': 'Japan (日本)', 'flag': '🇯🇵'},
    {'code': 'DE', 'name': 'Germany (德国)', 'flag': '🇩🇪'},
    {'code': 'FR', 'name': 'France (法国)', 'flag': '🇫🇷'},
    {'code': 'IN', 'name': 'India (印度)', 'flag': '🇮🇳'},
    {'code': 'BR', 'name': 'Brazil (巴西)', 'flag': '🇧🇷'},
    {'code': 'CA', 'name': 'Canada (加拿大)', 'flag': '🇨🇦'},
    {'code': 'AU', 'name': 'Australia (澳大利亚)', 'flag': '🇦🇺'},
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final hub = ref.watch(phoneCountrySyncControlCenterProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          GoRouter.of(context).goNamed(AppRouter.home);
        }
      },
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            l10n.selectCountry,
            style: TextStyle(fontWeight: FontWeight.w900, color: theme.colorScheme.onSurface),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, size: 20, color: theme.colorScheme.onSurface),
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                GoRouter.of(context).goNamed(AppRouter.home);
              }
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceVariant.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.public_rounded, size: 32, color: theme.colorScheme.primary),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.countrySyncSettingsTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.countrySyncSettingsSubtitle,
                            style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ..._countries.map((country) {
              final code = country['code']!;
              final isSelected = _selectedCountryCode == code;

              return Card(
                margin: const EdgeInsets.only(bottom: 8.0),
                elevation: isSelected ? 2 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: ListTile(
                  leading: Text(country['flag']!, style: const TextStyle(fontSize: 24)),
                  title: Text(country['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('ISO Code: $code'),
                  trailing: isSelected
                      ? Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary)
                      : const Icon(Icons.circle_outlined, color: Colors.grey),
                  onTap: () {
                    setState(() {
                      _selectedCountryCode = code;
                    });
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _isDownloading
                    ? null
                    : () async {
                        setState(() {
                          _isDownloading = true;
                        });
                        try {
                          await hub.downloadCountryData(_selectedCountryCode);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Downloaded database for $_selectedCountryCode successfully!')),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Download failed: $e')),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(() {
                              _isDownloading = false;
                            });
                          }
                        }
                      },
                icon: _isDownloading
                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.cloud_download_rounded),
                label: Text(_isDownloading ? l10n.loading : l10n.confirmButton, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
