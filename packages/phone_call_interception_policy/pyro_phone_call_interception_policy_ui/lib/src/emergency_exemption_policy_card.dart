import 'package:material_ui/material_ui.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';

/// 紧急呼叫后全局拦截豁免配置卡片组件 (EmergencyExemptionPolicyCard)
/// 100% 封装于微包内部，提供开启状态、放行时长下拉调节、内置与自定义紧急号码管理
class EmergencyExemptionPolicyCard extends StatefulWidget {
  final EmergencyPolicyConfig config;
  final ValueChanged<EmergencyPolicyConfig> onConfigChanged;
  final List<String> presetNumbers;
  final bool isCurrentlyExempted;
  final int? remainingSeconds;

  const EmergencyExemptionPolicyCard({
    super.key,
    required this.config,
    required this.onConfigChanged,
    this.presetNumbers = const [],
    this.isCurrentlyExempted = false,
    this.remainingSeconds,
  });

  @override
  State<EmergencyExemptionPolicyCard> createState() => _EmergencyExemptionPolicyCardState();
}

class _EmergencyExemptionPolicyCardState extends State<EmergencyExemptionPolicyCard> {
  bool _isPresetsExpanded = false;

  void _showAddNumberDialog(BuildContext context) {
    final theme = Theme.of(context);
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(Icons.add_ic_call_rounded, color: theme.colorScheme.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                '添加紧急号码',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '输入您所在地区的当地紧急电话（如社区求助站、保卫处、专线急救电话等）：',
                style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                autofocus: true,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: '紧急电话号码',
                  hintText: '例如: 120, 119, 010-12345',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.phone_rounded),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text('取消', style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
            ),
            FilledButton(
              onPressed: () {
                final text = controller.text.trim();
                if (text.isNotEmpty) {
                  final currentList = List<String>.from(widget.config.customNumbers);
                  if (!currentList.contains(text)) {
                    currentList.add(text);
                    widget.onConfigChanged(widget.config.copyWith(customNumbers: currentList));
                  }
                }
                Navigator.of(dialogCtx).pop();
              },
              child: const Text('添加'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final config = widget.config;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      color: theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头部：图标 + 标题 + 总开关
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.emergency_rounded, color: Colors.red, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '紧急呼叫放行防护',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '拨打紧急求助电话后，限时无条件放行所有来电',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: config.enabled,
                  onChanged: (val) {
                    widget.onConfigChanged(config.copyWith(enabled: val));
                  },
                ),
              ],
            ),

            if (widget.isCurrentlyExempted) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shield_rounded, color: Colors.red, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.remainingSeconds != null
                            ? '紧急豁免保护生效中 (剩余 ${(widget.remainingSeconds! / 60).ceil()} 分钟)'
                            : '紧急豁免保护生效中，来电将无条件直接接听',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            if (config.enabled) ...[
              const SizedBox(height: 16),
              Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6)),
              const SizedBox(height: 14),

              // 豁免时长设置
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '放行豁免持续时长',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '拨通后保持放行的时间窗口',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outlineVariant),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: [15, 30, 60, 120].contains(config.durationMinutes)
                            ? config.durationMinutes
                            : 30,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        onChanged: (newDuration) {
                          if (newDuration != null) {
                            widget.onConfigChanged(config.copyWith(durationMinutes: newDuration));
                          }
                        },
                        items: const [
                          DropdownMenuItem(value: 15, child: Text('15 分钟')),
                          DropdownMenuItem(value: 30, child: Text('30 分钟 (推荐)')),
                          DropdownMenuItem(value: 60, child: Text('1 小时')),
                          DropdownMenuItem(value: 120, child: Text('2 小时')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6)),
              const SizedBox(height: 14),

              // 自定义紧急号码专区
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '自定义紧急号码 (${config.customNumbers.length})',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '可添加当地急救、社区、家庭等重要号码',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: const Text('添加号码'),
                    style: FilledButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => _showAddNumberDialog(context),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              if (config.customNumbers.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
                  ),
                  child: Center(
                    child: Text(
                      '暂未添加自定义紧急电话，点击右上角快速添加',
                      style: TextStyle(fontSize: 12, color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                )
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: config.customNumbers.map((number) {
                    return InputChip(
                      avatar: const Icon(Icons.phone_rounded, size: 14, color: Colors.red),
                      label: Text(number, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      side: BorderSide(color: theme.colorScheme.outlineVariant),
                      deleteIcon: const Icon(Icons.close_rounded, size: 14),
                      onDeleted: () {
                        final updated = List<String>.from(config.customNumbers)..remove(number);
                        widget.onConfigChanged(config.copyWith(customNumbers: updated));
                      },
                    );
                  }).toList(),
                ),

              const SizedBox(height: 14),
              // 内置预设号码可折叠面板
              if (widget.presetNumbers.isNotEmpty) ...[
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _isPresetsExpanded = !_isPresetsExpanded;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          _isPresetsExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                          size: 18,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '查看全球内置紧急号码库 (${widget.presetNumbers.length} 个)',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (_isPresetsExpanded) ...[
                  const SizedBox(height: 6),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
                    ),
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: widget.presetNumbers.take(30).map((n) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            n,
                            style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurfaceVariant),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ],
            ],
          ],
        ),
      ),
    );
  }
}
