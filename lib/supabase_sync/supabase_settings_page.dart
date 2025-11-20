import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/purchase/purchase_state.dart';
// 1. 引入你的路由定义文件


import 'supabase_sync_manager.dart';
import 'supabase_sync_providers.dart';

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

  // ✅ 修正：直接使用 AppRouter 常量进行跳转
  bool _checkVipOrRedirect(bool isVip) {
    if (isVip) return true;
    
    // 直接使用常量，不再硬编码字符串
    context.pushNamed(AppRouter.purchaseSettings); 
    return false;
  }

  Future<void> _handleInitialize(bool isVip) async {
    if (!_checkVipOrRedirect(isVip)) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.initializing);
    try {
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      await ref.read(supabaseSyncControllerProvider.notifier).initializeDatabase();
    } finally {
      if (mounted) setState(() => _currentOp = _ActiveOperation.none);
    }
  }

  Future<void> _handleSync(bool isVip) async {
    if (!_checkVipOrRedirect(isVip)) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _currentOp = _ActiveOperation.syncing);
    try {
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
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
    final configAsync = ref.watch(supabaseConfigProvider);
    final purchaseState = ref.watch(purchaseStateProvider);
    final isVip = purchaseState.isPurchasedOrHasTempAccess();

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
          final bool canInteract = !isBusy;

          return Column(
            children: [
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
                        activeColor: Colors.blue,
                        onChanged: canInteract ? (val) {
                          ref.read(supabaseConfigProvider.notifier).toggleMasterDevice(val);
                        } : null,
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
                            enabled: canInteract,
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
                            enabled: canInteract,
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
                              enabled: canInteract,
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
                      onChanged: canInteract ? (val) {
                        ref.read(supabaseConfigProvider.notifier).toggleCallLogs(val);
                      } : null,
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
                                  onChanged: canInteract ? (val) {
                                    ref.read(supabaseConfigProvider.notifier).setSyncInterval(val.toInt());
                                  } : null,
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
                      onPressed: canInteract ? _handleSave : null,
                      icon: _currentOp == _ActiveOperation.saving
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Icon(Icons.save),
                      label: Text(AppLocalizations.of(context)!.saveButton),
                      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
                    ),
                    const SizedBox(height: 12),

                    // 2. Init Button (Master Only)
                    if (config.isMasterDevice) ...[
                      OutlinedButton.icon(
                        onPressed: canInteract ? () => _handleInitialize(isVip) : null,
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

                    // 3. Sync Button
                    FilledButton.icon(
                      onPressed: canInteract ? () => _handleSync(isVip) : null,
                      icon: _currentOp == _ActiveOperation.syncing
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : (isVip ? const Icon(Icons.sync) : const Icon(Icons.lock)), 
                      label: Text(isVip ? AppLocalizations.of(context)!.syncNowButton : AppLocalizations.of(context)!.exchangeVip),
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

class _SupabaseStatusBar extends ConsumerWidget {
  const _SupabaseStatusBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. 监听 VIP 状态
    final purchaseState = ref.watch(purchaseStateProvider);
    final isVip = purchaseState.isPurchasedOrHasTempAccess();
    
    // 2. 监听配置状态
    final config = ref.watch(supabaseConfigProvider).value;
    final isConfigured = config != null && config.url.isNotEmpty && config.anonKey.isNotEmpty;

    // 3. 定义样式和文本
    Color bgColor;
    IconData icon;
    Color iconColor;
    String titleText;
    String? subtitleText;
    VoidCallback? onTap;

    if (!isVip) {
      // --- 未购买状态 ---
      bgColor = Colors.amber.shade50;
      icon = Icons.lock_outline;
      iconColor = Colors.amber.shade800;
      
      // 主标题
      titleText = AppLocalizations.of(context)!.needVipAccess;
      // 副标题 (请确保 arb 文件中有 vipAccessSubtitle)
      subtitleText = AppLocalizations.of(context)!.vipAccessSubtitle;
      
      // 点击跳转逻辑
      onTap = () {
        context.pushNamed(AppRouter.purchaseSettings);
      };
    } else if (isConfigured) {
      // --- 已配置且是 VIP ---
      bgColor = Colors.green.shade50;
      icon = Icons.check_circle;
      iconColor = Colors.green;
      titleText = AppLocalizations.of(context)!.statusConnected;
      subtitleText = null; // 不需要副标题
      onTap = null; // 不需要点击
    } else {
      // --- 未配置但已是 VIP ---
      bgColor = Colors.grey.shade100;
      icon = Icons.settings_remote;
      iconColor = Colors.grey;
      titleText = AppLocalizations.of(context)!.statusNotConfigured;
      subtitleText = null;
      onTap = null;
    }

    // 4. 构建 UI
    return Material(
      color: bgColor, // 使用 Material 包裹以支持 InkWell 水波纹效果
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.statusLabel,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11, // 稍微调小标签字体
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      titleText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: iconColor,
                      ),
                    ),
                    // 如果有副标题（未购买时），显示它
                    if (subtitleText != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitleText,
                        style: TextStyle(
                          fontSize: 12,
                          color: iconColor.withValues(alpha:0.8),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // 如果可点击（未购买），在右侧显示一个小箭头作为提示
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios, 
                  size: 14, 
                  color: iconColor.withValues(alpha:0.5)
                ),
            ],
          ),
        ),
      ),
    );
  }
}
