import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:pyro_user_database_cloudflare/pyro_user_database_cloudflare.dart';
import 'package:pyro_user_database_hub/pyro_user_database_hub.dart';

/// 用户个人数据库与 Supabase / Cloudflare D1 云节点同步配置页面
class UserDatabaseSyncPage extends ConsumerStatefulWidget {
  const UserDatabaseSyncPage({super.key});

  @override
  ConsumerState<UserDatabaseSyncPage> createState() => _UserDatabaseSyncPageState();
}

class _UserDatabaseSyncPageState extends ConsumerState<UserDatabaseSyncPage> {
  final _workerUrlController = TextEditingController();
  final _apiSecretController = TextEditingController();
  bool _isTesting = false;
  String? _testMessage;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (GoRouter.of(context).canPop()) {
          context.pop();
        } else {
          GoRouter.of(context).goNamed(AppRouter.home);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.userDatabaseSyncTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            onPressed: () {
              if (GoRouter.of(context).canPop()) {
                context.pop();
              } else {
                GoRouter.of(context).goNamed(AppRouter.home);
              }
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.storage_rounded, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          l10n.userDatabaseSyncTitle,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.userDatabaseSyncSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Cloudflare D1 & Supabase 节点配置',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _workerUrlController,
                      decoration: const InputDecoration(
                        labelText: 'Worker / Supabase URL',
                        hintText: 'https://callruleapi.workers.dev',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _apiSecretController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'API Secret Key',
                        hintText: 'Enter API Key',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_testMessage != null) ...[
                      Text(
                        _testMessage!,
                        style: TextStyle(
                          color: _testMessage!.contains('成功') ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          icon: _isTesting
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.sync),
                          label: const Text('测试连通性'),
                          onPressed: _isTesting
                              ? null
                              : () async {
                                  setState(() {
                                    _isTesting = true;
                                    _testMessage = null;
                                  });
                                  try {
                                    final provider = CloudflareSyncProvider(
                                      workerUrl: _workerUrlController.text,
                                      apiSecret: _apiSecretController.text,
                                    );
                                    UserDatabaseHub.instance.registerAdapter(provider);
                                    final ok = await provider.testConnection();
                                    setState(() {
                                      _testMessage = ok ? '✅ 数据库云节点测试连通成功！' : '❌ 连通失败，请检查 URL 与密钥。';
                                    });
                                  } catch (e) {
                                    setState(() {
                                      _testMessage = '❌ 网络或密钥异常: $e';
                                    });
                                  } finally {
                                    setState(() {
                                      _isTesting = false;
                                    });
                                  }
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
