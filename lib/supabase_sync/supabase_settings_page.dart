import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';

import 'supabase_sync_manager.dart';
import 'supabase_sync_providers.dart';

/// 局部状态：当前正在进行的操作
enum _ActiveOperation { none, saving, initializing, syncing }

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
    // 只有当控制器为空时才填充，避免用户输入被覆盖
    if (_urlCtrl.text.isEmpty) _urlCtrl.text = config.url;
    if (_keyCtrl.text.isEmpty) _keyCtrl.text = config.anonKey;
    if (_connStringCtrl.text.isEmpty) _connStringCtrl.text = config.connectionString;
  }

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

  Future<void> _handleInitialize() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.initializing);
    try {
      // 先保存
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      // 再初始化
      await ref.read(supabaseSyncControllerProvider.notifier).initializeDatabase();
    } finally {
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  Future<void> _handleSync() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.syncing);
    try {
      // 先保存
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      // 再同步
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

  @override
  Widget build(BuildContext context) {
  
    
    // 监听配置加载状态
    final configAsync = ref.watch(supabaseConfigProvider);
    
    // 监听 VIP 状态 (用于控制整个页面的某些交互)
    final purchaseState = ref.watch(purchaseStateProvider);
    final isVip = purchaseState.isPurchasedOrHasTempAccess();

    // 监听同步结果
    ref.listen<AsyncValue<SyncResult?>>(supabaseSyncControllerProvider, (previous, next) {
      next.when(
        data: (result) {
          if (previous?.isLoading == true && result == null) {
            _showSnackBar(AppLocalizations.of(context)!.dbInitSuccess);
          } else if (result != null && result.success) {
            if (result.skipped) {
              _showSnackBar("Sync skipped (Interval)", isError: false);
            } else {
              _showSnackBar(AppLocalizations.of(context)!.syncSuccess(result.pushedCount, result.pulledCount));
            }
          } else if (result != null && !result.success) {
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
          
          final bool isBusy = _currentOp != _ActiveOperation.none;
          final bool canSync = isVip && !isBusy;

          return Column(
            children: [
              // ✅ 使用独立的无参数组件
              const _SupabaseStatusBar(),
              
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Master Device Switch
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade100),
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

                    // Form Fields
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
                    
                    // Call Logs Switch
                    SwitchListTile(
                      title: Text(AppLocalizations.of(context)!.syncCallHistory),
                      subtitle: Text(AppLocalizations.of(context)!.syncCallHistorySubtitle),
                      value: config.syncCallLogs,
                      onChanged: isBusy ? null : (val) {
                        ref.read(supabaseConfigProvider.notifier).toggleCallLogs(val);
                      },
                    ),

                    // Sync Interval Slider
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
                    const Divider(height: 30),

                    // 1. Save Button
                    OutlinedButton.icon(
                      onPressed: isBusy ? null : _handleSave,
                      icon: _currentOp == _ActiveOperation.saving
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.save),
                      label: Text(AppLocalizations.of(context)!.saveButton),
                      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
                    ),
                    const SizedBox(height: 12),

                    // 2. Init Button (Master & VIP Only)
                    if (config.isMasterDevice) ...[
                      OutlinedButton.icon(
                        onPressed: canSync ? _handleInitialize : null,
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

                    // 3. Sync Button (VIP Only)
                    FilledButton.icon(
                      onPressed: canSync ? _handleSync : null,
                      icon: _currentOp == _ActiveOperation.syncing
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : (isVip ? const Icon(Icons.sync) : const Icon(Icons.lock)),
                      label: Text(isVip ? AppLocalizations.of(context)!.syncNowButton : "Upgrade to Sync"), // 如果 "Upgrade to Sync" 也要多语言，请在 arb 中添加 key 并替换
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

/// 独立的无参数状态栏组件
/// 自动监听 VIP 和 Config 状态
class _SupabaseStatusBar extends ConsumerWidget {
  const _SupabaseStatusBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    
    // 1. 监听 VIP 状态
    final purchaseState = ref.watch(purchaseStateProvider);
    final isVip = purchaseState.isPurchasedOrHasTempAccess();
    
    // 2. 监听配置状态
   // AsyncValue.value 会返回当前的数据（如果存在），无论是 Loading 还是 Error 状态（如果之前有数据）
    final config = ref.watch(supabaseConfigProvider).value;
    final isConfigured = config != null && config.url.isNotEmpty && config.anonKey.isNotEmpty;

    Color bgColor;
    IconData icon;
    Color iconColor;
    String statusText;

    if (!isVip) {
      bgColor = Colors.amber.shade50;
      icon = Icons.lock;
      iconColor = Colors.amber.shade800;
      // 这里假设你在 arb 中添加了 vipRequiredForSync
      // 如果没有，暂时显示英文，或确保添加了该 Key
      statusText = AppLocalizations.of(context)!.needVipAccess; 
    } else if (isConfigured) {
      bgColor = Colors.green.shade50;
      icon = Icons.check_circle;
      iconColor = Colors.green;
      statusText = AppLocalizations.of(context)!.statusConnected;
    } else {
      bgColor = Colors.grey.shade100;
      icon = Icons.settings_remote;
      iconColor = Colors.grey;
      statusText = AppLocalizations.of(context)!.statusNotConfigured;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: bgColor,
      child: Row(
        children: [
          Icon(icon, color: iconColor),
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
                statusText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}