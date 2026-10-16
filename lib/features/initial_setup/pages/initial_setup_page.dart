import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

// 【零耦合原则】：仅依赖 core 层的基础实体和仓库，绝不引用 features/phone 或 features/plugin 下的任何类
import '../../../core/entities/subscription/subscription.dart';
import '../../../core/value_objects/url.dart';
import '../../../core/value_objects/rule_action.dart';
import '../../../core/provider/providers/phone_subscription_service_provider.dart';

import '../models/setup_config.dart';
import '../providers/initial_setup_provider.dart';

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
      appBar: AppBar(
        title: Text(l10n.initialSetupTitle),
        automaticallyImplyLeading: false,
      ),
      body: configAsync.when(
        data: (config) => _buildBody(context, config, l10n, theme),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.initialSetupGetFailed,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  err.toString(),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => _exit(context),
                      child: Text(l10n.initialSetupSkip),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton.icon(
                      onPressed: () => ref.invalidate(setupConfigProvider),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: Text(l10n.initialSetupRetry),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SetupConfig config, AppLocalizations l10n, ThemeData theme) {
    final detectedCode = ref.watch(detectedCountryCodeProvider).value?.toUpperCase();

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
          c.id.toLowerCase().contains(query);
    }).toList();

    return Column(
      children: [
        // 顶部控制卡片：采用标准 Material 3 Card
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.initialSetupDesc,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      l10n.initialSetupSourceTitle,
                      style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SegmentedButton<bool>(
                      showSelectedIcon: false,
                      segments: [
                        ButtonSegment<bool>(
                          value: false,
                          label: Text(l10n.initialSetupSourceGithub),
                        ),
                        ButtonSegment<bool>(
                          value: true,
                          label: Text(l10n.initialSetupSourceCdn),
                        ),
                      ],
                      selected: {_useCdn},
                      onSelectionChanged: (Set<bool> newSelection) {
                        final useCdn = newSelection.first;
                        setState(() {
                          _useCdn = useCdn;
                        });
                        ref.read(setupUseCdnProvider.notifier).setUseCdn(useCdn);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _useCustomUrl,
                      onChanged: (bool? val) {
                        setState(() {
                          _useCustomUrl = val ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _useCustomUrl = !_useCustomUrl;
                          });
                        },
                        child: Text(
                          l10n.initialSetupSourceCustom,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_useCustomUrl)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _customUrlController,
                            decoration: InputDecoration(
                              hintText: l10n.initialSetupCustomUrlHint,
                              border: const OutlineInputBorder(),
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            ),
                            onSubmitted: (_) => _fetchCustomUrl(),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _fetchCustomUrl,
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: Text(l10n.initialSetupCustomUrlLoad),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),

        // 搜索与批量选择控制条
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: l10n.initialSetupSearchHint,
                    prefixIcon: const Icon(Icons.search_rounded, size: 18),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 16),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilterChip(
                label: Text(
                  _selectedCountryIds.length == sortedCountries.length
                      ? l10n.initialSetupDeselectAll
                      : l10n.initialSetupSelectAll,
                ),
                selected: _selectedCountryIds.isNotEmpty,
                onSelected: (_) {
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
            ],
          ),
        ),

        const SizedBox(height: 8),

        // 规则列表，支持上滑下滑顺畅体验
        Expanded(
          child: filteredCountries.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off_rounded, size: 40, color: Colors.grey),
                      const SizedBox(height: 8),
                      Text(l10n.noData, style: theme.textTheme.bodyMedium),
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

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      elevation: isSelected ? 2 : 1,
                      child: CheckboxListTile(
                        title: Row(
                          children: [
                            Text(country.name),
                            if (country.countryCode.isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Chip(
                                labelPadding: EdgeInsets.zero,
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                label: Text(
                                  country.countryCode.toUpperCase(),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                            if (isCurrentLocation) ...[
                              const SizedBox(width: 6),
                              Chip(
                                avatar: const Icon(Icons.location_on, size: 12),
                                label: Text(
                                  l10n.initialSetupDetectedLocation,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ],
                        ),
                        subtitle: country.description.isNotEmpty
                            ? Text(
                                country.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              )
                            : null,
                        value: isSelected,
                        onChanged: (bool? val) {
                          setState(() {
                            if (val == true) {
                              _selectedCountryIds.add(country.id);
                            } else {
                              _selectedCountryIds.remove(country.id);
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
        ),

        // 扩展插件推荐区（若配置有）
        if (config.pluginsRecommendation != null)
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.extension_rounded),
              title: Text(config.pluginsRecommendation!.title),
              subtitle: Text(
                config.pluginsRecommendation!.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.open_in_new_rounded, size: 16),
              onTap: () async {
                final url = Uri.parse(config.pluginsRecommendation!.webPortalUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ),

        // 设置提示卡片
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.initialSetupSettingsHint,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                TextButton(
                  onPressed: () => context.pushNamed(AppRouter.settings),
                  child: Text(l10n.initialSetupGoToSettings),
                ),
              ],
            ),
          ),
        ),

        // 底部标准 Action 栏
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                TextButton(
                  onPressed: _isDownloading ? null : () => _exit(context),
                  child: Text(l10n.initialSetupSkip),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: (_selectedCountryIds.isEmpty || _isDownloading)
                      ? null
                      : () => _downloadSelected(config, l10n),
                  icon: _isDownloading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.download_rounded, size: 18),
                  label: Text(
                    _isDownloading
                        ? l10n.initialSetupSaving
                        : l10n.initialSetupSelectedCount(_selectedCountryIds.length),
                  ),
                ),
              ],
            ),
          ),
        )
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
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppPrefsKeys.hasCompletedInitialSetup, true);
    } catch (_) {}
    if (context.mounted) {
      if (context.canPop()) {
        context.pop();
      } else {
        context.goNamed('home');
      }
    }
  }

  Future<void> _downloadSelected(SetupConfig config, AppLocalizations l10n) async {
    setState(() {
      _isDownloading = true;
    });

    try {
      final phoneService = ref.read(phoneSubscriptionServiceProvider);
      
      for (final countryId in _selectedCountryIds) {
        final country = config.countriesData.firstWhere((c) => c.id == countryId);
        final effectiveUrl =
            (_useCustomUrl && _customUrlController.text.trim().isNotEmpty)
            ? _customUrlController.text.trim()
            : country.getEffectiveUrl(useCdn: _useCdn);
        
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
        
        await phoneService.save(subscription);
        await phoneService.importAndSaveRulesFromSubscription(subscription);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.initialSetupSaveSuccess)),
        );
        _exit(context);
      }
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
