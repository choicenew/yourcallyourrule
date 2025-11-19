import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  // 当 Provider 数据加载完成后，填充输入框
  void _populateControllers(SupabaseConfig config) {
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

  @override
  Widget build(BuildContext context) {
    // 监听配置状态
    final configAsync = ref.watch(supabaseConfigProvider);
    // 监听同步操作状态
    final syncStateAsync = ref.watch(supabaseSyncControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Cloud Backup & Sync")),
      body: configAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error loading settings: $err")),
        data: (config) {
          // 填充数据 (仅一次)
          _populateControllers(config);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                "Connect your personal Supabase database to sync data across devices.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _urlCtrl,
                      decoration: const InputDecoration(
                        labelText: "Supabase URL",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.link),
                      ),
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _keyCtrl,
                      decoration: const InputDecoration(
                        labelText: "Anon Key",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                      obscureText: true,
                      validator: (v) => v!.isEmpty ? "Required" : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _connStringCtrl,
                      decoration: const InputDecoration(
                        labelText: "Connection String (URI)",
                        hintText: "postgres://postgres:pass@db.xxx.supabase.co:5432/postgres",
                        helperText: "Only needed for 'Initialize Database'",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.storage),
                      ),
                      obscureText: true,
                      validator: (v) => v!.isEmpty ? "Required for init" : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // 开关
              SwitchListTile(
                title: const Text("Sync Call History"),
                subtitle: const Text("Include private call logs in sync"),
                value: config.syncCallLogs,
                onChanged: (val) {
                  ref.read(supabaseConfigProvider.notifier).toggleCallLogs(val);
                },
              ),

              const Divider(height: 30),

              // 状态显示区域
              if (syncStateAsync.isLoading)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator()),
                ),

              if (syncStateAsync.hasError)
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.red.shade50,
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(child: Text("Error: ${syncStateAsync.error}")),
                    ],
                  ),
                ),

              if (syncStateAsync.hasValue && syncStateAsync.value != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.green.shade50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("✅ Sync Successful", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                      Text("⬆️ Pushed: ${syncStateAsync.value!.pushedCount} items"),
                      Text("⬇️ Pulled: ${syncStateAsync.value!.pulledCount} items"),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              // 按钮区域
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: syncStateAsync.isLoading 
                        ? null 
                        : () async {
                            await _save(); // 先保存
                            ref.read(supabaseSyncControllerProvider.notifier).initializeDatabase();
                          },
                      icon: const Icon(Icons.settings_ethernet),
                      label: const Text("Initialize Supabase Database"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: syncStateAsync.isLoading 
                        ? null 
                        : () async {
                            await _save(); // 先保存
                            ref.read(supabaseSyncControllerProvider.notifier).runSync();
                          },
                      icon: const Icon(Icons.sync),
                      label: const Text("Sync Now"),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}