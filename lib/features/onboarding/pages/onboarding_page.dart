import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourcallyourrule/core/constants/app_prefs_keys.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/features/language/language_data.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 应用引导页面（原生系统主题适配版）
class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// 翻页处理
  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboardingFlow();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// 统一的引导流程完成/跳过入口 (唯一终点逻辑，收拢全部完成状态)
  Future<void> _completeOnboardingFlow() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // 1. 明确且仅标记 Onboarding 自身完成
      await prefs.setBool(AppPrefsKeys.firstLaunch, false);
      try {
        await prefs.reload();
      } catch (_) {}

      // 2. 检查初始设置状态按需跳转
      final hasCompletedSetup = prefs.getBool(AppPrefsKeys.hasCompletedInitialSetup) ?? false;
      if (!mounted) return;

      if (!hasCompletedSetup) {
        GoRouter.of(context).goNamed(AppRouter.initialSetup);
      } else {
        GoRouter.of(context).goNamed(AppRouter.home);
      }
    } catch (_) {
      if (mounted) {
        GoRouter.of(context).goNamed(AppRouter.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(localeProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(theme),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildWelcomePage(theme),
                  _buildLanguagePage(theme),
                  _buildFeaturePage1(theme),
                  _buildFeaturePage2(theme),
                  _buildPermissionsPage(theme),
                  _buildCompletePage(theme),
                ],
              ),
            ),
            _buildBottomBar(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // 进度条
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_currentPage + 1) / _totalPages,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          // 跳过按钮
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: TextButton(
                onPressed: _completeOnboardingFlow,
                style: TextButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  l10n.skip,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 上一步按钮
          _currentPage > 0
              ? OutlinedButton(
                  onPressed: _previousPage,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.onSurface,
                    side: BorderSide(color: theme.colorScheme.outlineVariant),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    l10n.previousStep,
                    style: const TextStyle(fontSize: 15),
                  ),
                )
              : const SizedBox(width: 100),
          // 下一步 / 开始使用按钮
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 2,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              _currentPage == _totalPages - 1 ? l10n.startUsing : l10n.nextStep,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalPages, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isActive ? 20 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive
                ? theme.colorScheme.primary
                : theme.colorScheme.primary.withValues(alpha: 0.25),
          ),
        );
      }),
    );
  }

  Widget _buildIconContainer({
    required IconData icon,
    required ThemeData theme,
    Color? customColor,
    double size = 110,
    double iconSize = 56,
  }) {
    final bg = customColor?.withValues(alpha: 0.15) ?? theme.colorScheme.primaryContainer;
    final fg = customColor ?? theme.colorScheme.primary;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: fg.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: fg,
      ),
    );
  }

  Widget _buildPageTemplate({
    required Widget icon,
    required String title,
    required ThemeData theme,
    Widget? content,
    String? description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 32),
          Text(
            title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          if (content != null) ...[
            const SizedBox(height: 20),
            content,
          ],
          if (description != null) ...[
            const SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ],
          const SizedBox(height: 32),
          _buildPageIndicator(theme),
        ],
      ),
    );
  }

  Widget _buildWelcomePage(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return _buildPageTemplate(
      theme: theme,
      icon: _buildIconContainer(
        icon: Icons.shield_rounded,
        theme: theme,
      ),
      title: l10n.welcome,
      content: Column(
        children: [
          Text(
            'Your Call Your Rule',
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      description: l10n.onboardingWelcomeDescription,
    );
  }

  Widget _buildLanguagePage(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    final asyncLocale = ref.watch(localeProvider);
    final List<Map<String, dynamic>> supportedLocales = languages;

    return _buildPageTemplate(
      theme: theme,
      icon: _buildIconContainer(
        icon: Icons.language_rounded,
        theme: theme,
        customColor: theme.colorScheme.secondary,
      ),
      title: l10n.selectYourLanguage,
      content: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        padding: const EdgeInsets.all(16),
        child: asyncLocale.when(
          data: (currentLocale) => LanguageSelectionWidget(
            supportedLocales: supportedLocales,
            currentLocale: currentLocale,
            localeNotifier: ref.read(localeProvider.notifier),
            showCurrentLanguage: false,
            showAds: false,
          ),
          loading: () => Center(
            child: CircularProgressIndicator(color: theme.colorScheme.primary),
          ),
          error: (error, stack) => Center(
            child: Text(
              'Error: $error',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ),
      ),
      description: l10n.onboardingLanguageDescription,
    );
  }

  Widget _buildFeaturePage1(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return _buildPageTemplate(
      theme: theme,
      icon: _buildIconContainer(
        icon: Icons.contact_phone_rounded,
        theme: theme,
      ),
      title: l10n.smartCallerId,
      content: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Center(
          child: Icon(
            Icons.phone_callback_rounded,
            size: 72,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      description: l10n.onboardingSmartCallerIdDescription,
    );
  }

  Widget _buildFeaturePage2(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return _buildPageTemplate(
      theme: theme,
      icon: _buildIconContainer(
        icon: Icons.block_rounded,
        theme: theme,
        customColor: theme.colorScheme.error,
      ),
      title: l10n.powerfulSpamBlocking,
      content: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.outlineVariant),
        ),
        child: Center(
          child: Icon(
            Icons.phonelink_erase_rounded,
            size: 72,
            color: theme.colorScheme.error,
          ),
        ),
      ),
      description: l10n.onboardingPowerfulSpamBlockingDescription,
    );
  }

  Widget _buildPermissionsPage(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIconContainer(
            icon: Icons.verified_user_rounded,
            theme: theme,
            customColor: Colors.green,
            size: 90,
            iconSize: 48,
          ),
          const SizedBox(height: 20),
          Text(
            l10n.grantNecessaryPermissions,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingPermissionsDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          _buildPermissionItem(
            theme: theme,
            icon: Icons.phone_rounded,
            title: l10n.phonePermission,
            description: l10n.phonePermissionDescription,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 12),
          _buildPermissionItem(
            theme: theme,
            icon: Icons.contacts_rounded,
            title: l10n.contactsPermission,
            description: l10n.contactsPermissionDescription,
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildPermissionItem(
            theme: theme,
            icon: Icons.screen_lock_portrait_rounded,
            title: l10n.callScreeningPermission,
            description: l10n.callScreeningPermissionDescription,
            color: theme.colorScheme.error,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              final result = await CallScreeningPlugin.requestCallScreeningRole();
              if (!result && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.callScreeningPermissionNotGranted),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              l10n.grantPermissions,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          _buildPageIndicator(theme),
        ],
      ),
    );
  }

  Widget _buildPermissionItem({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletePage(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return _buildPageTemplate(
      theme: theme,
      icon: _buildIconContainer(
        icon: Icons.rocket_launch_rounded,
        theme: theme,
      ),
      title: l10n.ready,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: Colors.green,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.allSettingsCompleted,
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      description: l10n.onboardingCompleteDescription,
    );
  }
}
