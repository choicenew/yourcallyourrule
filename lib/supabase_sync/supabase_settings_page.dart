import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
// 1. 确保引入定义 SyncResult 的文件
import 'supabase_sync_manager.dart'; 
import 'supabase_sync_providers.dart';
// 2. 确保引入生成的本地化包


class SupabaseSettingsPage extends ConsumerStatefulWidget {
  const SupabaseSettingsPage({super.key});

  @override
  ConsumerState<SupabaseSettingsPage> createState() => _SupabaseSettingsPageState();
}

class _SupabaseSettingsPageState extends ConsumerState<SupabaseSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _urlCtrl;
  late TextEditingController _keyCtrl;
  late TextEditingController _connStringCtrl;

  @override
  void initState() {
    super.initState();
    _urlCtrl = TextEditingController();
    _keyCtrl = TextEditingController();
    _connStringCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _urlCtrl.dispose();
    _keyCtrl.dispose();
    _connStringCtrl.dispose();
    super.dispose();
  }

  void _populateControllers(SupabaseConfig config) {
    // 只有当控制器为空时才赋值，防止用户输入时被重置
    if (_urlCtrl.text.isEmpty) _urlCtrl.text = config.url;
    if (_keyCtrl.text.isEmpty) _keyCtrl.text = config.anonKey;
    if (_connStringCtrl.text.isEmpty) _connStringCtrl.text = config.connectionString;
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(supabaseConfigProvider.notifier).saveConfig(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    // SnackBar 默认会自动消失，不需要额外逻辑
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 构建顶部的状态栏
  Widget _buildStatusBar(SupabaseConfig config) {
    // 简单的连接状态判断：如果有 URL 和 Key，视为“已配置/已连接”
    final isConfigured = config.url.isNotEmpty && config.anonKey.isNotEmpty;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: isConfigured ? Colors.green.shade50 : Colors.grey.shade100,
      child: Row(
        children: [
          Icon(
            isConfigured ? Icons.check_circle : Icons.info_outline,
            color: isConfigured ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.statusLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                isConfigured ? AppLocalizations.of(context)!.statusConnected : AppLocalizations.of(context)!.statusNotConfigured,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isConfigured ? Colors.green.shade700 : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final configAsync = ref.watch(supabaseConfigProvider);
    final syncStateAsync = ref.watch(supabaseSyncControllerProvider);

    // ✅ 监听器：处理成功或失败的弹窗
    ref.listen<AsyncValue<SyncResult?>>(supabaseSyncControllerProvider, (previous, next) {
      next.when(
        data: (result) {
          // 情况1: 初始化数据库成功 (result 为 null，但 loading 结束)
          if (previous?.isLoading == true && result == null) {
             _showSnackBar(AppLocalizations.of(context)!.dbInitSuccess);
          }
          // 情况2: 同步成功
          else if (result != null && result.success) {
            _showSnackBar(AppLocalizations.of(context)!.syncSuccess(result.pushedCount, result.pulledCount));
          }
          // 情况3: 同步虽然执行了但结果标识为失败
          else if (result != null && !result.success) {
            _showSnackBar(result.errorMessage ?? AppLocalizations.of(context)!.syncFailed, isError: true);
          }
        },
        error: (err, stack) {
          _showSnackBar("${AppLocalizations.of(context)!.errorPrefix}: $err", isError: true);
        },
        loading: () {}, // Loading 状态下不做操作
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.localDatabaseSyncTitle)),
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("${AppLocalizations.of(context)!.errorLoadingSettings}: $err")),
        data: (config) {
          _populateControllers(config);

          return Column(
            children: [
              // 1. 状态栏放在顶部
              _buildStatusBar(config),
              
              // 2. 剩余内容可滚动
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(
                      AppLocalizations.of(context)!.localDatabaseSyncDescription,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _urlCtrl,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.supabaseProjectUrl,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.link),
                            ),
                            validator: (v) => v!.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _keyCtrl,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.supabaseAnonKey,
                              hintText: AppLocalizations.of(context)!.supabaseAnonKeyHint,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.vpn_key),
                            ),
                            obscureText: true,
                            validator: (v) => v!.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _connStringCtrl,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.connectionString,
                              // 这里的 Hint 不太好做国际化，保留通用格式即可，或者也在 arb 定义
                              hintText: "postgres://postgres:pass@db.xxx...:5432/postgres",
                              helperText: AppLocalizations.of(context)!.connectionStringHelper,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.storage),
                            ),
                            obscureText: true,
                            validator: (v) => v!.isEmpty ? AppLocalizations.of(context)!.requiredInitField : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context)!.syncCallHistory),
                      subtitle: Text(AppLocalizations.of(context)!.syncCallHistorySubtitle),
                      value: config.syncCallLogs,
                      onChanged: (val) {
                        ref.read(supabaseConfigProvider.notifier).toggleCallLogs(val);
                      },
                    ),

                    const Divider(height: 30),

                    // 按钮区域
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: syncStateAsync.isLoading 
                              ? null 
                              : () async {
                                  await _save();
                                  ref.read(supabaseSyncControllerProvider.notifier).initializeDatabase();
                                },
                            icon: syncStateAsync.isLoading 
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) 
                              : const Icon(Icons.settings_ethernet),
                            label: Text(AppLocalizations.of(context)!.initDbButton),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: syncStateAsync.isLoading 
                              ? null 
                              : () async {
                                  await _save();
                                  ref.read(supabaseSyncControllerProvider.notifier).runSync();
                                },
                            icon: const Icon(Icons.sync),
                            label: Text(AppLocalizations.of(context)!.syncNowButton),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}