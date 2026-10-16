import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final configAsync = ref.watch(setupConfigProvider);

    return Scaffold(
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          l10n.initialSetupTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.black87,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: configAsync.when(
        data: (config) => _buildBody(context, config, l10n),
        loading: () => const Center(
          child: CircularProgressIndicator(color: EliteDopamineTheme.warmSunAmber),
        ),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: EliteDopamineTheme.vibrantCoral.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: EliteDopamineTheme.vibrantCoral,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.initialSetupGetFailed,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  err.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                        backgroundColor: EliteDopamineTheme.warmSunAmber,
                        foregroundColor: Colors.white,
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
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SetupConfig config, AppLocalizations l10n) {
    final detectedCode = ref.watch(detectedCountryCodeProvider).value?.toUpperCase();

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

    // 根据搜索框条件过滤几百条大型列表数据
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
        // 顶部描述与控制面板卡片
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: EliteDopamineTheme.warmCardDecoration(
            context: context,
            glowColor: EliteDopamineTheme.warmSunAmber,
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.initialSetupDesc,
                style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1.4),
              ),
              const SizedBox(height: 12),
              // 数据源选择 & 切换器
              Row(
                children: [
                  Text(
                    l10n.initialSetupSourceTitle,
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  SegmentedButton<bool>(
                    showSelectedIcon: false,
                    segments: [
                      ButtonSegment<bool>(
                        value: false,
                        label: Text(l10n.initialSetupSourceGithub, style: const TextStyle(fontSize: 12)),
                      ),
                      ButtonSegment<bool>(
                        value: true,
                        label: Text(l10n.initialSetupSourceCdn, style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                    selected: {_useCdn},
                    onSelectionChanged: (Set<bool> newSelection) {
                      final useCdn = newSelection.first;
                      setState(() {
                        _useCdn = useCdn;
                      });
                      // 响应式触发 Riverpod Provider 重拉对应数据源
                      ref.read(setupUseCdnProvider.notifier).state = useCdn;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 自定义 URL 输入与专属【加载/获取】按钮
              Row(
                children: [
                  Checkbox(
                    value: _useCustomUrl,
                    activeColor: EliteDopamineTheme.sunsetTangerine,
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
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
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
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                          onSubmitted: (_) => _fetchCustomUrl(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: EliteDopamineTheme.sunsetTangerine,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        ),
                        onPressed: _fetchCustomUrl,
                        icon: const Icon(Icons.download_rounded, size: 16),
                        label: Text(l10n.initialSetupCustomUrlLoad, style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // 快捷搜索栏与批量选择操作条（方便处理成百上千条规则列表）
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: l10n.initialSetupSearchHint,
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      prefixIcon: const Icon(Icons.search_rounded, size: 18, color: Colors.grey),
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
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // 全选 / 取消全选 Chip
              FilterChip(
                label: Text(
                  _selectedCountryIds.length == sortedCountries.length
                      ? l10n.initialSetupDeselectAll
                      : l10n.initialSetupSelectAll,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
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
                      Icon(Icons.search_off_rounded, size: 40, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        l10n.noData,
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
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

                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: EliteDopamineTheme.warmCardDecoration(
                        context: context,
                        glowColor: isSelected
                            ? EliteDopamineTheme.sunsetTangerine
                            : Colors.transparent,
                      ),
                      child: CheckboxListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        activeColor: EliteDopamineTheme.sunsetTangerine,
                        title: Row(
                          children: [
                            Text(
                              country.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            if (country.countryCode.isNotEmpty) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: EliteDopamineTheme.softLilac.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  country.countryCode.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: EliteDopamineTheme.softLilac,
                                  ),
                                ),
                              ),
                            ],
                            if (isCurrentLocation) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: EliteDopamineTheme.freshMint.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  l10n.initialSetupDetectedLocation,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: EliteDopamineTheme.freshMint,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        subtitle: country.description.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  country.description,
                                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                      );
                    },
                  ),
        ),

        // 扩展插件推荐区（若配置有）
        if (config.pluginsRecommendation != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: EliteDopamineTheme.skyAzure.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.extension_rounded, color: EliteDopamineTheme.skyAzure, size: 20),
              ),
              title: Text(
                config.pluginsRecommendation!.title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                config.pluginsRecommendation!.description,
                style: const TextStyle(fontSize: 11),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.open_in_new_rounded, size: 16, color: Colors.grey),
              onTap: () async {
                final url = Uri.parse(config.pluginsRecommendation!.webPortalUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ),

        // 设置提示卡片
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.info_outline_rounded,
                size: 18,
                color: EliteDopamineTheme.warmSunAmber,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.initialSetupSettingsHint,
                  style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                ),
              ),
              TextButton(
                onPressed: () => context.pushNamed(AppRouter.settings),
                child: Text(
                  l10n.initialSetupGoToSettings,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        // 底部晶莹悬浮 Action 控制面板
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Row(
              children: [
                TextButton(
                  onPressed: _isDownloading ? null : () => _exit(context),
                  child: Text(l10n.initialSetupSkip, style: const TextStyle(color: Colors.grey)),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    gradient: _selectedCountryIds.isNotEmpty
                        ? EliteDopamineTheme.heroWarmGradient
                        : null,
                    color: _selectedCountryIds.isEmpty ? Colors.grey[300] : null,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: _selectedCountryIds.isNotEmpty
                        ? [
                            BoxShadow(
                              color: EliteDopamineTheme.sunsetTangerine.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ]
                        : null,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    onPressed: (_selectedCountryIds.isEmpty || _isDownloading)
                        ? null
                        : () => _downloadSelected(config, l10n),
                    icon: _isDownloading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.download_rounded, size: 18),
                    label: Text(
                      _isDownloading
                          ? l10n.initialSetupSaving
                          : l10n.initialSetupSelectedCount(_selectedCountryIds.length),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
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
    ref.read(setupCustomUrlProvider.notifier).state =
        customUrl.isNotEmpty ? customUrl : null;
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
