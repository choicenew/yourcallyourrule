import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import 'package:yourcallyourrule/generated/app_localizations.dart';

// 【零耦合原则】：仅依赖 core 层的基础实体和仓库，绝不引用 features/phone 或 features/plugin 下的任何类
import '../../../core/entities/subscription/subscription.dart';
import '../../../core/value_objects/url.dart';
import '../../../core/value_objects/rule_action.dart';
import '../../../core/provider/basic_provider/subscription_repository_provider.dart';
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
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    // 可以在这里执行 IP 定位逻辑，定位成功后自动添加对应的 id 到 _selectedCountryIds 中
    // _autoDetectLocationAndSelect(); 
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            AppLocalizations.of(context)!.initialSetupDesc,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: config.countriesData.length,
            itemBuilder: (context, index) {
              final country = config.countriesData[index];
              final isSelected = _selectedCountryIds.contains(country.id);
              return CheckboxListTile(
                title: Text(country.name),
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

  void _exit(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed('home');
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
        
        final subscription = Subscription(
          id: const Uuid().v4(),
          name: country.name,
          url: Url.fromString(country.manifestUrl),
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
