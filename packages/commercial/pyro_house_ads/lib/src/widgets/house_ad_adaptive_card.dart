import 'package:material_ui/material_ui.dart';
import '../models/house_ad_slot.dart';
import '../engine/matrix_ad_arbitrator.dart';

/// 官方 ARB 字符串多语言动态解析器
typedef HouseAdStringResolver = String Function(BuildContext context, String key);

/// 广告点击事件回调 (由主 App 或 Manager 接管)
typedef HouseAdActionCallback = void Function(
  BuildContext context,
  HouseAdDecision decision,
);

/// 响应式轻量色彩填充自适应广告卡片 (Default Adaptive House Ad Card)
class HouseAdAdaptiveCard extends StatelessWidget {
  final HouseAdDecision decision;
  final HouseAdSlotType slotType;
  final HouseAdStringResolver? stringResolver;
  final HouseAdActionCallback? onAction;

  const HouseAdAdaptiveCard({
    super.key,
    required this.decision,
    required this.slotType,
    this.stringResolver,
    this.onAction,
  });

  String _resolveText(BuildContext context, String key, String? fallback) {
    if (stringResolver != null) {
      try {
        final text = stringResolver!(context, key);
        if (text.isNotEmpty && text != key) return text;
      } catch (_) {}
    }
    return fallback ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final item = decision.item;
    final isPrimary = decision.isPrimary;

    final title = _resolveText(context, item.titleKey, item.defaultTitle ?? (isPrimary ? 'VIP Privilege' : 'Recommended App'));
    final desc = _resolveText(context, item.descKey, item.defaultDesc ?? (isPrimary ? 'Unlock all features and remove ads' : 'Get it on Google Play'));
    final ctaText = item.ctaKey != null
        ? _resolveText(context, item.ctaKey!, isPrimary ? 'Upgrade' : 'Get')
        : (isPrimary ? 'Upgrade' : 'Get');

    final gradient = item.gradientColors.length >= 2
        ? item.gradientColors
        : const [Color(0xFF212121), Color(0xFF424242)];

    return LayoutBuilder(
      builder: (context, constraints) {
        switch (slotType) {
          case HouseAdSlotType.anchoredBanner:
            return _buildBannerLayout(context, title, desc, ctaText, gradient, item.icon);
          case HouseAdSlotType.nativeSmall:
            return _buildNativeSmallLayout(context, title, desc, ctaText, gradient, item.icon);
          case HouseAdSlotType.mrec:
          case HouseAdSlotType.nativeMedium:
            return _buildNativeMediumLayout(context, title, desc, ctaText, gradient, item.icon);
          case HouseAdSlotType.nativeLarge:
            return _buildNativeLargeLayout(context, title, desc, ctaText, gradient, item.icon);
          case HouseAdSlotType.interstitial:
            return _buildInterstitialLayout(context, title, desc, ctaText, gradient, item.icon);
        }
      },
    );
  }

  Widget _buildBannerLayout(
    BuildContext context,
    String title,
    String desc,
    String ctaText,
    List<Color> gradient,
    IconData? icon,
  ) {
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  desc,
                  style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _buildCtaButton(context, ctaText, isSmall: true),
        ],
      ),
    );
  }

  Widget _buildNativeSmallLayout(
    BuildContext context,
    String title,
    String desc,
    String ctaText,
    List<Color> gradient,
    IconData? icon,
  ) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradient),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(51),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon ?? Icons.star_rounded, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1),
                const SizedBox(height: 2),
                Text(desc, style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 11), maxLines: 1),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _buildCtaButton(context, ctaText),
        ],
      ),
    );
  }

  Widget _buildNativeMediumLayout(
    BuildContext context,
    String title,
    String desc,
    String ctaText,
    List<Color> gradient,
    IconData? icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon ?? Icons.bolt_rounded, color: Colors.white, size: 26),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(76),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  decision.isPrimary ? 'VIP' : 'PROMO',
                  style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15), maxLines: 1, overflow: TextOverflow.ellipsis),
          Text(desc, style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: _buildCtaButton(context, ctaText),
          ),
        ],
      ),
    );
  }

  Widget _buildNativeLargeLayout(
    BuildContext context,
    String title,
    String desc,
    String ctaText,
    List<Color> gradient,
    IconData? icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon ?? Icons.auto_awesome_rounded, color: Colors.white, size: 48),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text(desc, style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 13), textAlign: TextAlign.center),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: _buildCtaButton(context, ctaText),
          ),
        ],
      ),
    );
  }

  Widget _buildInterstitialLayout(
    BuildContext context,
    String title,
    String desc,
    String ctaText,
    List<Color> gradient,
    IconData? icon,
  ) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(76),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon ?? Icons.workspace_premium_rounded, color: Colors.white, size: 56),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(desc, style: TextStyle(color: Colors.white.withAlpha(204), fontSize: 14), textAlign: TextAlign.center),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: _buildCtaButton(context, ctaText),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCtaButton(BuildContext context, String ctaText, {bool isSmall = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 10 : 16,
          vertical: isSmall ? 4 : 10,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () => onAction?.call(context, decision),
      child: Text(
        ctaText,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: isSmall ? 12 : 14),
      ),
    );
  }
}
