import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 来电显示身份信息卡片（全量国际化，支持悬浮窗/灵动岛/通知多模式实机测试）
class VerificationCallerIdCard extends StatelessWidget {
  final CallerIdData callerIdData;
  final String fallbackPhoneNumber;
  final VoidCallback onTestOverlay;
  final VoidCallback onCloseOverlay;
  final VoidCallback onTestLiveActivity;
  final VoidCallback onTestNotification;
  final VoidCallback onTestDefaultMode;

  const VerificationCallerIdCard({
    super.key,
    required this.callerIdData,
    required this.fallbackPhoneNumber,
    required this.onTestOverlay,
    required this.onCloseOverlay,
    required this.onTestLiveActivity,
    required this.onTestNotification,
    required this.onTestDefaultMode,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final displayName = callerIdData.name?.isNotEmpty == true
        ? callerIdData.name!
        : fallbackPhoneNumber;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部：头像与基本信息
          Row(
            children: [
              CircleAvatar(
                backgroundImage: callerIdData.avatarImage,
                radius: 26,
                backgroundColor: EliteDopamineTheme.sunsetTangerine,
                child: callerIdData.avatarImage == null
                    ? Text(
                        callerIdData.labels?.isNotEmpty == true
                            ? callerIdData.labels!.first.label[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      [
                        callerIdData.countryName,
                        callerIdData.region,
                        callerIdData.carrier,
                      ].where((e) => e != null && e.isNotEmpty).join(' • '),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 详细字段列表
          const SizedBox(height: 14),
          const Divider(height: 1),
          const SizedBox(height: 12),

          _buildDetailRow(l10n.carrier, callerIdData.carrier ?? l10n.unknown),
          _buildDetailRow(l10n.country, callerIdData.countryName ?? l10n.unknown),
          if (callerIdData.region != null && callerIdData.region!.isNotEmpty)
            _buildDetailRow(l10n.enableLocationSummary, callerIdData.region!),
          _buildDetailRow(l10n.type, callerIdData.numberType.name),
          _buildDetailRow(l10n.callerIdMarkedByCount(callerIdData.count), '${callerIdData.count}'),
          if (callerIdData.name != null && callerIdData.name!.isNotEmpty)
            _buildDetailRow(l10n.contactNameLabel, callerIdData.name!),

          // 标签列表
          if (callerIdData.labels?.isNotEmpty == true) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: callerIdData.labels!.map((l) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: EliteDopamineTheme.warmSunAmber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    l.label,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: EliteDopamineTheme.warmSunAmber,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // 来电显示测试工具箱标题
          Row(
            children: [
              const Icon(
                Icons.science_rounded,
                size: 16,
                color: Color(0xFF6C5CE7),
              ),
              const SizedBox(width: 6),
              Text(
                '${l10n.testButton} (${l10n.callerIdDisplayMode})',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // 多模式测试按钮网格
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onTestOverlay,
                  icon: const Icon(Icons.picture_in_picture_alt_rounded, size: 14),
                  label: const Text('Overlay', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF6C5CE7),
                    side: const BorderSide(color: Color(0xFF6C5CE7), width: 1.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onCloseOverlay,
                  icon: const Icon(Icons.close_fullscreen_rounded, size: 14),
                  label: Text(l10n.cancel, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.redAccent,
                    side: const BorderSide(color: Colors.redAccent, width: 1.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onTestLiveActivity,
                  icon: const Icon(Icons.bolt_rounded, size: 14),
                  label: const Text('Live Island', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: EliteDopamineTheme.sunsetTangerine,
                    side: const BorderSide(color: EliteDopamineTheme.sunsetTangerine, width: 1.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onTestNotification,
                  icon: const Icon(Icons.notifications_active_rounded, size: 14),
                  label: Text(l10n.notifications, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: EliteDopamineTheme.freshMint,
                    side: const BorderSide(color: EliteDopamineTheme.freshMint, width: 1.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onTestDefaultMode,
                  icon: const Icon(Icons.play_arrow_rounded, size: 16),
                  label: Text(l10n.testButton, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
