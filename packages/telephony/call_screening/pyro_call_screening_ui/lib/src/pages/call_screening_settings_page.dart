import 'package:material_ui/material_ui.dart';

class CallScreeningSettingsPage extends StatelessWidget {
  const CallScreeningSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('来电前置门禁设置 (Call Screening)'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            color: colorScheme.surfaceContainerHighest.withAlpha(80),
            child: const ListTile(
              leading: Icon(Icons.security),
              title: Text('门禁安检过滤服务已开启'),
              subtitle: Text('拦截引擎将在电话响铃前毫秒级进行黑白名单与 AI 规则比对'),
            ),
          ),
        ],
      ),
    );
  }
}
