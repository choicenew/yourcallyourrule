import 'package:flutter/material.dart';
import 'package:pyro_call_control_protocol/pyro_call_control_protocol.dart';

/// Interactive UI tile for configuring action behavior.
class CallActionConfigTile extends StatelessWidget {
  final CallActionType actionType;
  final bool isSelected;
  final ValueChanged<CallActionType>? onTap;

  const CallActionConfigTile({
    super.key,
    required this.actionType,
    this.isSelected = false,
    this.onTap,
  });

  String get _title {
    switch (actionType) {
      case CallActionType.allow:
        return '放行呼叫 (Allow)';
      case CallActionType.reject:
        return '阻断挂断 (Reject / Block)';
      case CallActionType.silence:
        return '静音不接听 (Silence)';
      case CallActionType.answerThenHangup:
        return '秒接秒挂 (Answer then Hangup)';
      case CallActionType.voicemail:
        return '转接语音信箱 (Voicemail)';
    }
  }

  String get _subtitle {
    switch (actionType) {
      case CallActionType.allow:
        return '正常响铃，不进行任何拦截处置';
      case CallActionType.reject:
        return '系统级直接挂断拒绝呼叫';
      case CallActionType.silence:
        return '静音关闭来电铃声，保持未接状态';
      case CallActionType.answerThenHangup:
        return '接通1秒后挂断，消耗骚扰源话费并闭麦保护隐私';
      case CallActionType.voicemail:
        return '将来电直接重定向至语音信箱';
    }
  }

  IconData get _icon {
    switch (actionType) {
      case CallActionType.allow:
        return Icons.call_made;
      case CallActionType.reject:
        return Icons.call_end;
      case CallActionType.silence:
        return Icons.volume_off;
      case CallActionType.answerThenHangup:
        return Icons.phone_callback;
      case CallActionType.voicemail:
        return Icons.voicemail;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: isSelected ? 2 : 0,
      color: isSelected ? colorScheme.primaryContainer.withAlpha(128) : colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: ListTile(
        leading: Icon(
          _icon,
          color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
        ),
        title: Text(
          _title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          _subtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: colorScheme.primary)
            : null,
        onTap: onTap != null ? () => onTap!(actionType) : null,
      ),
    );
  }
}
