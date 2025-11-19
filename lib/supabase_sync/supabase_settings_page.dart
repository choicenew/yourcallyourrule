import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

// 引入我们的业务文件
import 'supabase_sync_manager.dart'; 
import 'supabase_sync_providers.dart';

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
    if (_urlCtrl.text.isEmpty) _urlCtrl.text = config.url;
    if (_keyCtrl.text.isEmpty) _keyCtrl.text = config.anonKey;
    if (_connStringCtrl.text.isEmpty) _connStringCtrl.text = config.connectionString;
  }

  Future<void> _saveOnly() async {
    if (_formKey.currentState!.validate()) {
      await ref.read(supabaseConfigProvider.notifier).saveSettings(
        url: _urlCtrl.text.trim(),
        anonKey: _keyCtrl.text.trim(),
        connectionString: _connStringCtrl.text.trim(),
      );
      if (mounted) {
         _showSnackBar(AppLocalizations.of(context)!.configSaved);
      }
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

  Widget _buildStatusBar(SupabaseConfig config, AppLocalizations l10n) {
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
    final l10n = AppLocalizations.of(context)!;
    final configAsync = ref.watch(supabaseConfigProvider);
    final syncStateAsync = ref.watch(supabaseSyncControllerProvider);

    // 监听结果
    ref.listen<AsyncValue<SyncResult?>>(supabaseSyncControllerProvider, (previous, next) {
      next.when(
        data: (result) {
          if (previous?.isLoading == true && result == null) {
             _showSnackBar(AppLocalizations.of(context)!.dbInitSuccess);
          }
          else if (result != null && result.success) {
             if (result.skipped) {
               // 显示跳过提示 (可选)
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

          return Column(
            children: [
              _buildStatusBar(config, l10n),
              
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
                        activeColor: Colors.blue,
                        onChanged: (val) {
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
                          
                          if (config.isMasterDevice) ...[
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _connStringCtrl,
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
                      onChanged: (val) {
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
                                  onChanged: (val) {
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

                    // 按钮组
                    OutlinedButton.icon(
                      onPressed: syncStateAsync.isLoading ? null : _saveOnly,
                      icon: const Icon(Icons.save),
                      label: Text(AppLocalizations.of(context)!.saveButton),
                      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 45)),
                    ),
                    const SizedBox(height: 12),

                    if (config.isMasterDevice) ...[
                      OutlinedButton.icon(
                        onPressed: syncStateAsync.isLoading 
                          ? null 
                          : () async {
                              await _saveOnly();
                              ref.read(supabaseSyncControllerProvider.notifier).initializeDatabase();
                            },
                        icon: const Icon(Icons.settings_ethernet, color: Colors.orange),
                        label: Text(AppLocalizations.of(context)!.initDbButton, style: const TextStyle(color: Colors.orange)),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 45),
                          side: const BorderSide(color: Colors.orange),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],

                    FilledButton.icon(
                      onPressed: syncStateAsync.isLoading 
                        ? null 
                        : () async {
                            await _saveOnly();
                            // 点击按钮强制同步
                            ref.read(supabaseSyncControllerProvider.notifier).runSync(force: true);
                          },
                      icon: syncStateAsync.isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
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