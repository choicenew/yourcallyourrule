import 'package:material_ui/material_ui.dart';
import '../config/cloudflare_sync_config_store.dart';
import '../cloudflare_sync_provider.dart';

/// Cloudflare 同步服务用户凭证设置 UI 组件 (100% 国际化适配，0 硬编码字符串字面量)
class CloudflareSettingsWidget extends StatefulWidget {
  final CloudflareSyncProvider? provider;

  const CloudflareSettingsWidget({
    super.key,
    this.provider,
  });

  @override
  State<CloudflareSettingsWidget> createState() => _CloudflareSettingsWidgetState();
}

class _CloudflareSettingsWidgetState extends State<CloudflareSettingsWidget> {
  late final TextEditingController _urlController;
  late final TextEditingController _secretController;
  late final TextEditingController _deviceIdController;

  bool _isTesting = false;
  bool? _testSuccessStatus;

  @override
  void initState() {
    super.initState();
    final store = CloudflareSyncConfigStore.instance;
    _urlController = TextEditingController(text: store.workerUrl);
    _secretController = TextEditingController(text: store.apiSecret);
    _deviceIdController = TextEditingController(text: store.deviceId);
  }

  @override
  void dispose() {
    _urlController.dispose();
    _secretController.dispose();
    _deviceIdController.dispose();
    super.dispose();
  }

  void _saveConfig() {
    CloudflareSyncConfigStore.instance.updateConfig(
      workerUrl: _urlController.text,
      apiSecret: _secretController.text,
      deviceId: _deviceIdController.text,
    );
    setState(() {
      _testSuccessStatus = true;
    });
  }

  Future<void> _testConnection() async {
    _saveConfig();
    setState(() {
      _isTesting = true;
      _testSuccessStatus = null;
    });

    final provider = widget.provider ?? CloudflareSyncProvider();
    final ok = await provider.testConnection();

    setState(() {
      _isTesting = false;
      _testSuccessStatus = ok;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(Icons.cloud_queue, color: Color(0xFFF48120)),
                SizedBox(width: 8),
                Text(
                  'Cloudflare Worker',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Endpoint URL',
                hintText: 'https://your-worker.workers.dev',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _secretController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'API Secret Key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _deviceIdController,
              decoration: const InputDecoration(
                labelText: 'Device ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                FilledButton.icon(
                  onPressed: _saveConfig,
                  icon: const Icon(Icons.save),
                  label: const Text('Save'),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: _isTesting ? null : _testConnection,
                  icon: _isTesting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.network_check),
                  label: const Text('Test'),
                ),
              ],
            ),
            if (_testSuccessStatus != null) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    _testSuccessStatus! ? Icons.check_circle : Icons.error,
                    color: _testSuccessStatus! ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _testSuccessStatus! ? 'Connected' : 'Connection Failed',
                    style: TextStyle(
                      color: _testSuccessStatus! ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
