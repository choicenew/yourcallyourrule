import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';

import '../../../core/entities/subscription/subscription.dart';
import '../../../core/value_objects/url.dart';
import '../../../core/value_objects/rule_action.dart';
import '../../../core/provider/providers/phone_subscription_service_provider.dart';
import '../../../core/provider/providers/plugin_manager_service_provider.dart';
import 'package:yourcallyourrule/features/call_statistic/data/services/call_statistics_provider.dart';

import '../models/setup_config.dart';
import '../providers/initial_setup_provider.dart';
import '../widgets/initial_setup_header_card.dart';
import '../widgets/initial_setup_search_bar.dart';
import '../widgets/initial_setup_tile.dart';
import '../widgets/initial_setup_bottom_bar.dart';

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
        error: (err, stack) => _buildErrorView(context, err, l10n),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SetupConfig config, AppLocalizations l10n) {
    final detectedCode = ref.watch(detectedCountryCodeProvider).value?.toUpperCase();
    final theme = Theme.of(context);

    // 优先展示用户所在地区（置顶排序）
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

    // 插件推荐区：若远程配置未提供，默认降级展示 GitHub 官方插件库引导卡片
    final pluginRec = config.pluginsRecommendation ??
        PluginRecommendation(
          title: l10n.pluginManagement,
          description: l10n.pluginRulesInfo,
          webPortalUrl: 'https://github.com/choicenew/yourcallrule/tree/main/plugins',
        );

    return Column(
      children: [
        // 1. 顶部控制卡片
        InitialSetupHeaderCard(
          useCdn: _useCdn,
          useCustomUrl: _useCustomUrl,
          customUrlController: _customUrlController,
          onUseCdnChanged: (val) => setState(() => _useCdn = val),
          onUseCustomUrlChanged: (val) => setState(() => _useCustomUrl = val),
          onFetchCustomUrl: _fetchCustomUrl,
        ),

        const SizedBox(height: 8),

        // 2. 搜索与控制工具栏
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

        // 3. 规则/插件列表，采用通用 InitialSetupTile
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

        // 4. 扩展插件推荐区 (常驻引导)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.extension_rounded, color: theme.colorScheme.secondary, size: 20),
            ),
            title: Text(
              pluginRec.title,
              style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
            ),
            subtitle: Text(
              pluginRec.description,
              style: TextStyle(fontSize: 11.5, color: theme.colorScheme.onSurfaceVariant),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              Icons.open_in_new_rounded,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            onTap: () async {
              final url = Uri.parse(pluginRec.webPortalUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ),

        // 5. 设置提示卡片
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant, width: 1.0),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.initialSetupSettingsHint,
                  style: TextStyle(fontSize: 11.5, color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed(AppRouter.settings),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  l10n.initialSetupGoToSettings,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 6. 底部晶莹悬浮 Action 控制面板
        InitialSetupBottomBar(
          selectedCount: _selectedCountryIds.length,
          isDownloading: _isDownloading,
          onSkip: () => _exit(context),
          onDownloadSelected: () => _downloadSelected(config, l10n),
        ),
      ],
    );
  }

  Widget _buildErrorView(BuildContext context, Object err, AppLocalizations l10n) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.initialSetupGetFailed,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              err.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => ref.invalidate(setupConfigProvider),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: Text(l10n.initialSetupRetry),
                ),
              ],
            ),
          ],
        ),
      ),
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
        final effectiveUrl =
            (_useCustomUrl && _customUrlController.text.trim().isNotEmpty)
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

      // 1. 毫秒级将订阅配置写入本地 SQLite 数据库
      for (final sub in subscriptionsToSave) {
        await phoneService.save(sub);
      }

      // 2. 给出成功提示并【立刻关闭向导进入主界面】，绝对不卡顿等待网络下载
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.initialSetupSaveSuccess)),
        );
        _exit(context);
      }

      // 3. 在后台静默异步拉取并解析规则/插件（完全非阻塞 UI）
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

        // 后台规则/插件全量导入完成后，主动通知统计状态提供者重新加载最新统计数据
        ref.invalidate(callStatisticsProvider);
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
