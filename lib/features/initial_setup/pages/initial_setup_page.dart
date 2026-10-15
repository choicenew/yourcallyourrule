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
  bool _isDownloading = false;
  bool _useCdn = false;
  bool _useCustomUrl = false;
  bool _hasAutoSelected = false;

  @override
  void dispose() {
    _customUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final configAsync = ref.watch(setupConfigProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.initialSetupTitle),
        // 隐藏返回按钮，确保用户做一个明确的决定（跳过或下载）
        automaticallyImplyLeading: false, 
      ),
      body: configAsync.when(
        data: (config) => _buildBody(context, config),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.initialSetupGetFailed, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(err.toString(), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(setupConfigProvider),
                child: Text(AppLocalizations.of(context)!.initialSetupRetry),
              ),
              TextButton(
                onPressed: () => _exit(context),
                child: Text(AppLocalizations.of(context)!.initialSetupSkip),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, SetupConfig config) {
    final detectedCode = ref
        .watch(detectedCountryCodeProvider)
        .value
        ?.toUpperCase();

    // 优先展示用户所在地区（置顶排序）
    final sortedCountries = List<CountryData>.from(config.countriesData);
    if (detectedCode != null && detectedCode.isNotEmpty) {
      sortedCountries.sort((a, b) {
        if (a.id.toUpperCase() == detectedCode) return -1;
        if (b.id.toUpperCase() == detectedCode) return 1;
        return 0;
      });

      // 首次获取到定位时，默认自动勾选用户所在地区（保留用户自由取消或多选其他国家）
      if (!_hasAutoSelected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_hasAutoSelected) {
            final match = sortedCountries
                .where((c) => c.id.toUpperCase() == detectedCode)
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

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context)!.initialSetupDesc,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        // 允许用户自主选择 GitHub 原源还是 CDN 镜像加速源
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            children: [
              Text(
                AppLocalizations.of(context)!.initialSetupSourceTitle,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SegmentedButton<bool>(
                segments: [
                  ButtonSegment<bool>(
                    value: false,
                    label: Text(
                      AppLocalizations.of(context)!.initialSetupSourceGithub,
                    ),
                  ),
                  ButtonSegment<bool>(
                    value: true,
                    label: Text(
                      AppLocalizations.of(context)!.initialSetupSourceCdn,
                    ),
                  ),
                ],
                selected: {_useCdn},
                onSelectionChanged: (Set<bool> newSelection) {
                  setState(() {
                    _useCdn = newSelection.first;
                  });
                },
              ),
            ],
          ),
        ),
        // 自主选择：使用默认推荐链接，还是手工填入自定义最新链接（防止版本未及时更新发版）
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        AppLocalizations.of(context)!.initialSetupSourceCustom,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
              if (_useCustomUrl)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    right: 12.0,
                    bottom: 8.0,
                  ),
                  child: TextField(
                    controller: _customUrlController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.initialSetupCustomUrlHint,
                      border: const OutlineInputBorder(),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            itemCount: sortedCountries.length,
            itemBuilder: (context, index) {
              final country = sortedCountries[index];
              final isSelected = _selectedCountryIds.contains(country.id);
              final isCurrentLocation =
                  detectedCode != null &&
                  country.id.toUpperCase() == detectedCode;

              return CheckboxListTile(
                title: Row(
                  children: [
                    Text(country.name),
                    if (isCurrentLocation) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          AppLocalizations.of(
                            context,
                          )!.initialSetupDetectedLocation,
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                subtitle: Text(country.description),
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
        if (config.pluginsRecommendation != null) ...[
          const Divider(),
          ListTile(
            leading: const Icon(Icons.extension),
            title: Text(config.pluginsRecommendation!.title),
            subtitle: Text(config.pluginsRecommendation!.description),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              final url = Uri.parse(config.pluginsRecommendation!.webPortalUrl);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              }
            },
          ),
        ],
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 20,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.initialSetupSettingsHint,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.pushNamed(AppRouter.settings);
                },
                child: Text(
                  AppLocalizations.of(context)!.initialSetupGoToSettings,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                TextButton(
                  onPressed: _isDownloading ? null : () => _exit(context),
                  child: Text(AppLocalizations.of(context)!.initialSetupSkip),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: (_selectedCountryIds.isEmpty || _isDownloading)
                      ? null
                      : () => _downloadSelected(config),
                  icon: _isDownloading
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.download),
                  label: Text(_isDownloading ? AppLocalizations.of(context)!.initialSetupSaving : AppLocalizations.of(context)!.initialSetupSave),
                ),
              ],
            ),
          ),
        )
      ],
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

  Future<void> _downloadSelected(SetupConfig config) async {
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
          autoUpdate: true, // 默认开启自动更新
          tableType: 'phone', 
        );
        
        // 保存订阅并立即下载解析规则入库
        await phoneService.save(subscription);
        await phoneService.importAndSaveRulesFromSubscription(subscription);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.initialSetupSaveSuccess)),
        );
        // 配置完成后，关闭此引导页
        _exit(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.initialSetupSaveFailed(e.toString()))),
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
