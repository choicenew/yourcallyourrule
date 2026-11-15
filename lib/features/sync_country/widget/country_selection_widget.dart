import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:world_countries/world_countries.dart';
import 'package:pyro_phone_country_sync_hub/pyro_phone_country_sync_hub.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 支持 N 个国家多选批量下载、带已选国家 Chips 选框标签栏的动态选择页
class CountrySelectionWidget extends ConsumerStatefulWidget {
  const CountrySelectionWidget({super.key});

  @override
  ConsumerState<CountrySelectionWidget> createState() => _CountrySelectionWidgetState();
}

class _CountrySelectionWidgetState extends ConsumerState<CountrySelectionWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final Set<String> _selectedCountryCodes = {'US', 'CN'};
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final hub = ref.watch(phoneCountrySyncControlCenterProvider);

    final allCountries = WorldCountry.list;
    final filteredCountries = allCountries.where((country) {
      final name = country.name.common.toLowerCase();
      final code = country.code.toLowerCase();
      final codeShort = country.codeShort.toLowerCase();
      return name.contains(_searchQuery) || code.contains(_searchQuery) || codeShort.contains(_searchQuery);
    }).toList();

    final selectedCountryWidgets = _selectedCountryCodes.map((code) {
      final country = allCountries.firstWhere(
        (c) => c.codeShort == code,
        orElse: () => WorldCountry.fromCode(code),
      );
      return Padding(
        padding: const EdgeInsets.only(right: 6.0),
        child: InputChip(
          avatar: Text(country.emoji, style: const TextStyle(fontSize: 16)),
          label: Text('${country.name.common} ($code)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          onDeleted: () {
            setState(() {
              _selectedCountryCodes.remove(code);
            });
          },
          deleteIcon: const Icon(Icons.cancel_rounded, size: 16),
          backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.6),
          labelStyle: TextStyle(color: theme.colorScheme.onPrimaryContainer),
        ),
      );
    }).toList();

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search (${allCountries.length} countries)',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            if (_selectedCountryCodes.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: SizedBox(
                  height: 42,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: selectedCountryWidgets,
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                itemCount: filteredCountries.length,
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];
                  final code = country.codeShort;
                  final isSelected = _selectedCountryCodes.contains(code);

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
                      leading: Text(country.emoji, style: const TextStyle(fontSize: 26)),
                      title: Text(country.name.common, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('ISO: $code | ${country.namesNative.firstOrNull?.common ?? country.name.common}'),
                      trailing: Checkbox(
                        value: isSelected,
                        activeColor: theme.colorScheme.primary,
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked == true) {
                              _selectedCountryCodes.add(code);
                            } else {
                              _selectedCountryCodes.remove(code);
                            }
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedCountryCodes.remove(code);
                          } else {
                            _selectedCountryCodes.add(code);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: (_isDownloading || _selectedCountryCodes.isEmpty)
                      ? null
                      : () async {
                          setState(() {
                            _isDownloading = true;
                          });
                          try {
                            for (final code in _selectedCountryCodes) {
                              await hub.downloadCountryData(code);
                            }
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Downloaded database for ${_selectedCountryCodes.length} countries successfully!')),
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
                  label: Text(
                    _isDownloading
                        ? l10n.loading
                        : '${l10n.confirmButton} (${_selectedCountryCodes.length} Selected)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
