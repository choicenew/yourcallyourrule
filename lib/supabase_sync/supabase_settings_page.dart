import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 引入业务文件
import 'supabase_sync_manager.dart'; 
import 'supabase_sync_providers.dart';

/// 定义当前正在进行的操作类型
enum _ActiveOperation {
  none,
  saving,
  initializing,
  syncing
}

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

  // ✅ 新增：局部状态，用于区分哪个按钮在转圈
  _ActiveOperation _currentOp = _ActiveOperation.none;

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
    if (_urlCtrl.text.isEmpty) _urlCtrl.text = config.url;
    if (_keyCtrl.text.isEmpty) _keyCtrl.text = config.anonKey;
    if (_connStringCtrl.text.isEmpty) _connStringCtrl.text = config.connectionString;
  }

  /// 包装保存操作
  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _currentOp = _ActiveOperation.saving);
    try {
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      if (mounted) {
         _showSnackBar(AppLocalizations.of(context)!.configSaved);
      }
    } finally {
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  /// 包装初始化操作
  Future<void> _handleInitialize() async {
    // 先保存
    if (!_formKey.currentState!.validate()) return;
    
    setState(() => _currentOp = _ActiveOperation.initializing);
    try {
      // 1. 保存配置
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      // 2. 执行初始化
      await ref.read(supabaseSyncControllerProvider.notifier).initializeDatabase();
    } finally {
      // 注意：这里不置为 none，因为 Controller 状态变化会触发下面的 ref.listen，
      // 或者等待 Controller 变回 AsyncData。
      // 但为了保险起见，我们在 finally 里恢复 UI 状态
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  /// 包装同步操作
  Future<void> _handleSync() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.syncing);
    try {
      // 1. 保存
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      // 2. 同步
      await ref.read(supabaseSyncControllerProvider.notifier).runSync(force: true);
    } finally {
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildStatusBar(SupabaseConfig config) {
    final isConfigured = config.url.isNotEmpty && config.anonKey.isNotEmpty;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: isConfigured ? Colors.green.shade50 : Colors.grey.shade100,
      child: Row(
        children: [
          Icon(
            isConfigured ? Icons.check_circle : Icons.settings_remote,
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
   
    final configAsync = ref.watch(supabaseConfigProvider);
    
    // 监听结果 (用于弹窗提示)
    ref.listen<AsyncValue<SyncResult?>>(supabaseSyncControllerProvider, (previous, next) {
      next.when(
        data: (result) {
          if (previous?.isLoading == true && result == null) {
             _showSnackBar(AppLocalizations.of(context)!.dbInitSuccess);
          }
          else if (result != null && result.success) {
             if (result.skipped) {
               _showSnackBar("Sync skipped (Interval)", isError: false);
             } else {
               _showSnackBar(AppLocalizations.of(context)!.syncSuccess(result.pushedCount, result.pulledCount));
             }
          }
          else if (result != null && !result.success) {
            _showSnackBar(result.errorMessage ?? AppLocalizations.of(context)!.syncFailed, isError: true);
          }
        },
        error: (err, stack) {
          _showSnackBar("${AppLocalizations.of(context)!.errorPrefix}: $err", isError: true);
        },
        loading: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.localDatabaseSyncTitle)),
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("${AppLocalizations.of(context)!.errorLoadingSettings}: $err")),
        data: (config) {
          _populateControllers(config);
          
          // 如果任何操作正在进行，禁用所有交互
          final bool isBusy = _currentOp != _ActiveOperation.none;

          return Column(
            children: [
              _buildStatusBar(config),
              
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // 主设备开关
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade100)
                      ),
                      child: SwitchListTile(
                        title: Text(
                          AppLocalizations.of(context)!.masterDeviceLabel, 
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                        ),
                        subtitle: Text(AppLocalizations.of(context)!.masterDeviceHelp, style: const TextStyle(fontSize: 12)),
                        value: config.isMasterDevice,
                        activeThumbColor: Colors.blue,
                        onChanged: isBusy ? null : (val) {
                          ref.read(supabaseConfigProvider.notifier).toggleMasterDevice(val);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _urlCtrl,
                            enabled: !isBusy,
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
                            enabled: !isBusy,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(context)!.supabaseAnonKey,
                              hintText: AppLocalizations.of(context)!.supabaseAnonKeyHint,
                              border: const OutlineInputBorder(),
                              prefixIcon: const Icon(Icons.vpn_key),
                            ),
                            obscureText: true,
                            validator: (v) => v!.isEmpty ? AppLocalizations.of(context)!.requiredField : null,
                          ),
                          
                          if (config.isMasterDevice) ...[
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _connStringCtrl,
                              enabled: !isBusy,
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)!.connectionString,
                                hintText: "postgres://postgres:pass@db.xxx...:5432/postgres",
                                helperText: AppLocalizations.of(context)!.connectionStringHelper,
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange, width: 2),
                                ),
                                prefixIcon: const Icon(Icons.storage, color: Colors.orange),
                              ),
                              obscureText: true,
                              validator: (v) => (config.isMasterDevice && (v == null || v.isEmpty)) 
                                  ? AppLocalizations.of(context)!.requiredInitField 
                                  : null,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context)!.syncCallHistory),
                      subtitle: Text(AppLocalizations.of(context)!.syncCallHistorySubtitle),
                      value: config.syncCallLogs,
                      onChanged: isBusy ? null : (val) {
                        ref.read(supabaseConfigProvider.notifier).toggleCallLogs(val);
                      },
                    ),

                    // 时间间隔 Slider
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.syncIntervalLabel,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Slider(
                                  value: config.syncIntervalHours.toDouble(),
                                  min: 1,
                                  max: 24,
                                  divisions: 23,
                                  label: "${config.syncIntervalHours} h",
                                  onChanged: isBusy ? null : (val) {
                                    ref.read(supabaseConfigProvider.notifier).setSyncInterval(val.toInt());
                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.syncIntervalValue(config.syncIntervalHours),
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                         GoogleAdWidget(adInfo: AdManager.bannerAd),
                    const Divider(height: 30),

                    // =================================================
                    // 按钮组 - 修复了转圈逻辑
                    // =================================================

                    // 1. 保存按钮
                    OutlinedButton.icon(
                      onPressed: isBusy ? null : _handleSave,
                      icon: _currentOp == _ActiveOperation.saving
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.save),
                      label: Text(AppLocalizations.of(context)!.saveButton),
                      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
                    ),
                    const SizedBox(height: 12),

                    // 2. 初始化按钮 (仅 Master)
                    if (config.isMasterDevice) ...[
                      OutlinedButton.icon(
                        onPressed: isBusy ? null : _handleInitialize,
                        icon: _currentOp == _ActiveOperation.initializing
                            ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.orange))
                            : const Icon(Icons.settings_ethernet, color: Colors.orange),
                        label: Text(AppLocalizations.of(context)!.initDbButton, style: const TextStyle(color: Colors.orange)),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                          side: const BorderSide(color: Colors.orange),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    // 3. 同步按钮
                    FilledButton.icon(
                      onPressed: isBusy ? null : _handleSync,
                      icon: _currentOp == _ActiveOperation.syncing
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
                          : const Icon(Icons.sync),
                      label: Text(AppLocalizations.of(context)!.syncNowButton),
                      style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
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