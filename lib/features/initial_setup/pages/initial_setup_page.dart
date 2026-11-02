import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import '../../../core/entities/subscription/subscription.dart';
import '../../../core/value_objects/url.dart';
import '../../../core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/phone/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/plugin/services/plugin_manager_service.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';

import '../models/setup_config.dart';
import '../providers/initial_setup_provider.dart';
import '../widgets/initial_setup_header_card.dart';
import '../widgets/initial_setup_search_bar.dart';
import '../widgets/initial_setup_tile.dart';
import '../widgets/initial_setup_plugin_card.dart';
import '../widgets/initial_setup_settings_hint_card.dart';
import '../widgets/initial_setup_bottom_bar.dart';
import '../widgets/initial_setup_error_view.dart';

class InitialSetupPage extends ConsumerStatefulWidget {
  const InitialSetupPage({super.key});

  @override
  ConsumerState<InitialSetupPage> createState() => _InitialSetupPageState();
}

class _InitialSetupPageState extends ConsumerState<InitialSetupPage> {
  final Set<String> _selectedCountryIds = {};
  final TextEditingController _customUrlController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  bool _isDownloading = false;
  bool _useCdn = false;
  bool _useCustomUrl = false;
  bool _hasAutoSelected = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    ref.read(initialSetupServiceProvider).completeInitialSetup();
  }

  @override
  void dispose() {
    _customUrlController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final configAsync = ref.watch(setupConfigProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.initialSetupTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: configAsync.when(
        data: (config) => _buildBody(context, config, l10n),
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.colorScheme.primary),
        ),
        error: (err, stack) => InitialSetupErrorView(
          error: err,
          onSkip: () => _exit(context),
          onRetry: () => ref.invalidate(setupConfigProvider),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SetupConfig config, AppLocalizations l10n) {
    final detectedCode = ref.watch(detectedCountryCodeProvider).value?.toUpperCase();
    final theme = Theme.of(context);

    final sortedCountries = List<CountryData>.from(config.countriesData);
    if (detectedCode != null && detectedCode.isNotEmpty) {
      sortedCountries.sort((a, b) {
        final aMatch = a.countryCode.toUpperCase() == detectedCode || a.id.toUpperCase() == detectedCode;
        final bMatch = b.countryCode.toUpperCase() == detectedCode || b.id.toUpperCase() == detectedCode;
        if (aMatch && !bMatch) return -1;
        if (!aMatch && bMatch) return 1;
        return 0;
      });

      if (!_hasAutoSelected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_hasAutoSelected) {
            final match = sortedCountries
                .where((c) => c.countryCode.toUpperCase() == detectedCode || c.id.toUpperCase() == detectedCode)
                .firstOrNull;
            if (match != null) {
              setState(() {
                _selectedCountryIds.add(match.id);
                _hasAutoSelected = true;
              });
            }
          }
        });
      }
    }

    final filteredCountries = sortedCountries.where((c) {
      if (_searchQuery.trim().isEmpty) return true;
      final query = _searchQuery.toLowerCase().trim();
      return c.name.toLowerCase().contains(query) ||
          c.description.toLowerCase().contains(query) ||
          c.countryCode.toLowerCase().contains(query) ||
          c.ruleType.toLowerCase().contains(query) ||
          c.id.toLowerCase().contains(query);
    }).toList();

    final pluginRec = config.pluginsRecommendation ??
        PluginRecommendation(
          title: l10n.pluginManagement,
          description: l10n.pluginRulesInfo,
          webPortalUrl: 'https://github.com/choicenew/yourcallrule/tree/main/plugins',
        );

    return Column(
      children: [
        InitialSetupHeaderCard(
          useCdn: _useCdn,
          useCustomUrl: _useCustomUrl,
          customUrlController: _customUrlController,
          onUseCdnChanged: (val) => setState(() => _useCdn = val),
          onUseCustomUrlChanged: (val) => setState(() => _useCustomUrl = val),
          onFetchCustomUrl: _fetchCustomUrl,
        ),
        const SizedBox(height: 8),
        InitialSetupSearchBar(
          searchController: _searchController,
          searchQuery: _searchQuery,
          isAllSelected: _selectedCountryIds.length == sortedCountries.length,
          isAnySelected: _selectedCountryIds.isNotEmpty,
          onSearchChanged: (val) => setState(() => _searchQuery = val),
          onClearSearch: () {
            _searchController.clear();
            setState(() => _searchQuery = '');
          },
          onToggleSelectAll: () {
            setState(() {
              if (_selectedCountryIds.length == sortedCountries.length) {
                _selectedCountryIds.clear();
              } else {
                _selectedCountryIds.clear();
                _selectedCountryIds.addAll(sortedCountries.map((c) => c.id));
              }
            });
          },
        ),
        const SizedBox(height: 8),
        Expanded(
          child: filteredCountries.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 40,
                        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.noData,
                        style: TextStyle(color: theme.colorScheme.onSurfaceVariant, fontSize: 13),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  physics: const BouncingScrollPhysics(),
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    final isSelected = _selectedCountryIds.contains(country.id);
                    final isCurrentLocation = detectedCode != null &&
                        (country.countryCode.toUpperCase() == detectedCode ||
                            country.id.toUpperCase() == detectedCode);

                    return InitialSetupTile(
                      country: country,
                      isSelected: isSelected,
                      isCurrentLocation: isCurrentLocation,
                      onChanged: (bool? val) {
                        setState(() {
                          if (val == true) {
                            _selectedCountryIds.add(country.id);
                          } else {
                            _selectedCountryIds.remove(country.id);
                          }
                        });
                      },
                    );
                  },
                ),
        ),
        InitialSetupPluginCard(pluginRec: pluginRec),
        const InitialSetupSettingsHintCard(),
        InitialSetupBottomBar(
          selectedCount: _selectedCountryIds.length,
          isDownloading: _isDownloading,
          onSkip: () => _exit(context),
          onDownloadSelected: () => _downloadSelected(config, l10n),
        ),
      ],
    );
  }

  void _fetchCustomUrl() {
    final customUrl = _customUrlController.text.trim();
    ref.read(setupCustomUrlProvider.notifier).setCustomUrl(
          customUrl.isNotEmpty ? customUrl : null,
        );
  }

  Future<void> _exit(BuildContext context) async {
    await ref.read(initialSetupServiceProvider).completeInitialSetup();
    if (context.mounted) {
      context.goNamed('home');
    }
  }

  Future<void> _downloadSelected(SetupConfig config, AppLocalizations l10n) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final phoneService = ref.read(phoneSubscriptionServiceProvider);
      final pluginService = ref.read(pluginManagerServiceProvider);

      final List<Subscription> subscriptionsToSave = [];
      final List<String> pluginUrlsToInstall = [];

      for (final countryId in _selectedCountryIds) {
        final country = config.countriesData.firstWhere((c) => c.id == countryId);
        final effectiveUrl = (_useCustomUrl && _customUrlController.text.trim().isNotEmpty)
            ? _customUrlController.text.trim()
            : country.getEffectiveUrl(useCdn: _useCdn);

        if (country.ruleType.toLowerCase() == 'plugin') {
          pluginUrlsToInstall.add(effectiveUrl);
        } else {
          final subscription = Subscription(
            id: const Uuid().v4(),
            name: country.name,
            url: Url.fromString(effectiveUrl),
            isEnabled: true,
            action: RuleAction.block,
            lastUpdated: DateTime.now(),
            autoUpdate: true,
            tableType: 'phone',
          );
          subscriptionsToSave.add(subscription);
        }
      }

      for (final sub in subscriptionsToSave) {
        await phoneService.save(sub);
      }

      final container = ref.container;

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.initialSetupSaveSuccess)),
        );
        _exit(context);
      }

      Future.microtask(() async {
        for (final sub in subscriptionsToSave) {
          try {
            await phoneService.importAndSaveRulesFromSubscription(sub);
          } catch (e) {
            debugPrint('[InitialSetupPage] Background import rules failed for ${sub.name}: $e');
          }
        }

        for (final pluginUrl in pluginUrlsToInstall) {
          try {
            await pluginService.addPluginFromUrl(pluginUrl);
          } catch (e) {
            debugPrint('[InitialSetupPage] Background install plugin failed for $pluginUrl: $e');
          }
        }

        container.invalidate(callStatisticsProvider);
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.initialSetupSaveFailed(e.toString()))),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }
}
