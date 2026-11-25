import 'package:material_ui/material_ui.dart';
import 'package:pyro_phone_call_interception_policy_protocol/pyro_phone_call_interception_policy_protocol.dart';
import 'l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context);
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
                l10n.addEmergencyNumberTitle,
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
                l10n.addEmergencyNumberDesc,
                style: TextStyle(fontSize: 13, color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.phone,
                autofocus: true,
                style: TextStyle(color: theme.colorScheme.onSurface),
                decoration: InputDecoration(
                  labelText: l10n.emergencyPhoneLabel,
                  hintText: l10n.emergencyPhoneHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.phone_rounded),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(l10n.cancel, style: TextStyle(color: theme.colorScheme.onSurfaceVariant)),
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
              child: Text(l10n.add),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
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
                        l10n.emergencyExemptionTitle,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.emergencyExemptionSubtitle,
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
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddNumberDialog(context),
                icon: const Icon(Icons.add_circle_outline_rounded, size: 18, color: Colors.red),
                label: Text(
                  l10n.addEmergencyNumberButton,
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.red.withValues(alpha: 0.4)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
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
                            ? l10n.emergencyExemptionActiveWithTime((widget.remainingSeconds! / 60).ceil())
                            : l10n.emergencyExemptionActive,
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
                        l10n.durationTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.durationSubtitle,
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
                        items: [
                          DropdownMenuItem(value: 15, child: Text(l10n.duration15Min)),
                          DropdownMenuItem(value: 30, child: Text(l10n.duration30Min)),
                          DropdownMenuItem(value: 60, child: Text(l10n.duration1Hour)),
                          DropdownMenuItem(value: 120, child: Text(l10n.duration2Hours)),
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
                        l10n.customEmergencyNumbers(config.customNumbers.length),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.customEmergencySubtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  FilledButton.tonalIcon(
                    icon: const Icon(Icons.add_rounded, size: 16),
                    label: Text(l10n.addEmergencyNumberButton),
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
                      l10n.noCustomEmergencyNumbers,
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
                          l10n.viewGlobalPresetNumbers(widget.presetNumbers.length),
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
