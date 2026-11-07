import 'package:flutter/material.dart';

/// 广告卡片容器与防 0 高度塌陷骨架屏 (PyroAdSkeletonContainer)
/// 加载阶段锁定空间不发生剧烈 Layout Shift 弹跳，彻底失败时才静默折叠。
class PyroAdSkeletonContainer extends StatelessWidget {
  final Widget? child;
  final bool isLoaded;
  final bool isFailed;
  final double height;
  final double? width;

  const PyroAdSkeletonContainer({
    super.key,
    this.child,
    required this.isLoaded,
    required this.isFailed,
    this.height = 50.0,
    this.width,
  });

  Widget _buildCardWrapper(BuildContext context, Widget content) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBg = theme.colorScheme.surfaceContainerHighest.withOpacity(isDark ? 0.45 : 0.65);
    final borderColor = theme.colorScheme.outlineVariant.withOpacity(0.35);

    return Container(
      width: width ?? double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: borderColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Center(child: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isFailed) {
      return const SizedBox.shrink();
    }

    if (isLoaded && child != null) {
      return _buildCardWrapper(context, child!);
    }

    // 正在加载中：骨架屏占位，锁定空间防剧烈弹跳
    return _buildCardWrapper(
      context,
      SizedBox(
        height: height,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "AD",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
