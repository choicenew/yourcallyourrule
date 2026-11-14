import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import 'package:pyro_phone_subscription_protocol/pyro_phone_subscription_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/rule_action.dart';
import 'package:yourcallyourrule/features/phone_subscription/services/phone_subscription_service.dart';
import 'package:yourcallyourrule/features/phone_plugin/services/plugin_manager_service.dart';

import 'package:yourcallyourrule/features/initial_setup/models/setup_config.dart';
import 'package:yourcallyourrule/features/initial_setup/providers/initial_setup_provider.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_header_card.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_search_bar.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_tile.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_plugin_card.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_settings_hint_card.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_bottom_bar.dart';
import 'package:yourcallyourrule/features/initial_setup/widgets/initial_setup_error_view.dart';

/// 云端规则与插件初始向导主页面组件
class InitialSetupPage extends ConsumerStatefulWidget {
  const InitialSetupPage({super.key});

  @override
  ConsumerState<InitialSetupPage> createState() => _InitialSetupPageState();
}

class _InitialSetupPageState extends ConsumerState<InitialSetupPage> {
  final Set<String> _selectedCountryIds = {};
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _customUrlController = TextEditingController();
  String _searchQuery = '';
  bool _useCdn = false;
  bool _useCustomUrl = false;
  bool _isDownloading = false;
  String? _detectedCountryCode;

  @override
  void initState() {
    super.initState();
    _initAutoDetection();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _customUrlController.dispose();
    super.dispose();
  }

  Future<void> _initAutoDetection() async {
    try {
      final code = await ref.read(detectedCountryCodeProvider.future);
      if (code != null && mounted) {
        setState(() {
          _detectedCountryCode = code;
        });
      }
    } catch (_) {}
  }

  Future<void> _exit(BuildContext context) async {
    await ref.read(initialSetupServiceProvider).completeInitialSetup();
    if (!mounted) return;
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/');
    }
  }

  void _fetchCustomUrl(AppLocalizations l10n) {
    final url = _customUrlController.text.trim();
    if (url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.deepLinkEmptyUrlError)),
      );
      return;
    }
    ref.read(setupCustomUrlProvider.notifier).setCustomUrl(url);
    ref.invalidate(setupConfigProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final setupConfigAsync = ref.watch(setupConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.initialSetupTitle),
        actions: [
          TextButton(
            onPressed: () => _exit(context),
            child: Text(l10n.initialSetupSkip),
          ),
        ],
      ),
      body: setupConfigAsync.when(
        data: (config) => _buildBody(context, config, l10n),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => InitialSetupErrorView(
          error: err,
          onSkip: () => _exit(context),
          onRetry: () => ref.invalidate(setupConfigProvider),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SetupConfig config, AppLocalizations l10n) {
    final pluginRec = config.pluginsRecommendation;

    final filteredCountries = config.countriesData.where((c) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return c.name.toLowerCase().contains(q) ||
          c.id.toLowerCase().contains(q) ||
          c.countryCode.toLowerCase().contains(q);
    }).toList();

    // 默认自动勾选符合当前 IP 国家代码的项目
    if (_detectedCountryCode != null && _selectedCountryIds.isEmpty) {
      final matched = config.countriesData.where(
        (c) => c.countryCode.toLowerCase() == _detectedCountryCode!.toLowerCase(),
      );
      for (final m in matched) {
        _selectedCountryIds.add(m.id);
      }
    }

    final isAllSelected = filteredCountries.isNotEmpty &&
        filteredCountries.every((c) => _selectedCountryIds.contains(c.id));
    final isAnySelected = _selectedCountryIds.isNotEmpty;

    return Column(
      children: [
        InitialSetupHeaderCard(
          useCdn: _useCdn,
          useCustomUrl: _useCustomUrl,
          customUrlController: _customUrlController,
          onUseCdnChanged: (val) {
            setState(() => _useCdn = val);
            ref.read(setupUseCdnProvider.notifier).setUseCdn(val);
          },
          onUseCustomUrlChanged: (val) => setState(() => _useCustomUrl = val),
          onFetchCustomUrl: () => _fetchCustomUrl(l10n),
        ),
        InitialSetupSearchBar(
          searchController: _searchController,
          searchQuery: _searchQuery,
          isAllSelected: isAllSelected,
          isAnySelected: isAnySelected,
          onSearchChanged: (q) => setState(() => _searchQuery = q),
          onClearSearch: () {
            _searchController.clear();
            setState(() => _searchQuery = '');
          },
          onToggleSelectAll: () {
            setState(() {
              if (isAllSelected) {
                _selectedCountryIds.clear();
              } else {
                for (final c in filteredCountries) {
                  _selectedCountryIds.add(c.id);
                }
              }
            });
          },
        ),
        Expanded(
          child: filteredCountries.isEmpty
              ? Center(child: Text(l10n.noData))
              : ListView.builder(
                  itemCount: filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = filteredCountries[index];
                    final isSelected = _selectedCountryIds.contains(country.id);
                    return InitialSetupTile(
                      country: country,
                      isSelected: isSelected,
                      isCurrentLocation: country.countryCode.toLowerCase() == _detectedCountryCode?.toLowerCase(),
                      onChanged: (val) {
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
        if (pluginRec != null) InitialSetupPluginCard(pluginRec: pluginRec),
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

  Future<void> _downloadSelected(SetupConfig config, AppLocalizations l10n) async {
    if (_selectedCountryIds.isEmpty) return;

    setState(() {
      _isDownloading = true;
    });

    try {
      final phoneService = ref.read(phoneSubscriptionServiceProvider);
      final pluginService = ref.read(pluginManagerServiceProvider);

      final List<PhoneSubscriptionPayload> subscriptionsToSave = [];

      for (final countryId in _selectedCountryIds) {
        final country = config.countriesData.firstWhere((c) => c.id == countryId);
        final effectiveUrl = (_useCustomUrl && _customUrlController.text.trim().isNotEmpty)
            ? _customUrlController.text.trim()
            : country.getEffectiveUrl(useCdn: _useCdn);

        if (country.ruleType.toLowerCase() == 'plugin') {
          await pluginService.addPluginFromUrl(effectiveUrl);
        } else {
          final sub = await phoneService.addSubscription(country.name, effectiveUrl);
          subscriptionsToSave.add(sub);
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.initialSetupSaveSuccess)),
        );
        _exit(context);
      }

      // 后台异步解析规则
      Future.microtask(() async {
        for (final sub in subscriptionsToSave) {
          try {
            await phoneService.updateRulesFromSubscription(sub);
          } catch (e) {
            debugPrint('[InitialSetupPage] Background import rules failed: $e');
          }
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.operationFailure}: $e')),
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
