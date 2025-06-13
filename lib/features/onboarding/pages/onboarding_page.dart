import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/language/language_data.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 应用引导页面
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

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      GoRouter.of(context).goNamed('home');
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

  void _skipOnboarding() {
    GoRouter.of(context).goNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFB74D), Color(0xFFFF7043)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _buildWelcomePage(),
                    _buildLanguagePage(),
                    _buildFeaturePage1(),
                    _buildFeaturePage2(),
                    _buildPermissionsPage(),
                    _buildCompletePage(),
                  ],
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // 进度条
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (_currentPage + 1) / _totalPages,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          // 跳过按钮
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: TextButton(
                onPressed: _skipOnboarding,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  AppLocalizations.of(context)!.skip,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 上一步按钮
          _currentPage > 0
              ? ElevatedButton(
                  onPressed: _previousPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFFFB74D),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.previousStep,
                    style: const TextStyle(fontSize: 16),
                  ),
                )
              : const SizedBox(width: 100),
          // 下一步按钮
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFFFB74D),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              _currentPage == _totalPages - 1
                  ? AppLocalizations.of(context)!.startUsing
                  : AppLocalizations.of(context)!.nextStep,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_totalPages, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == _currentPage
                ? Colors.white
                : Colors.white.withValues(alpha: 0.3),
          ),
        );
      }),
    );
  }

  // 提取通用的图标容器构建方法
  Widget _buildIconContainer({
    required IconData icon,
    required Color backgroundColor,
    double size = 120,
    double iconSize = 60,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: backgroundColor == Colors.white ? const Color(0xFFFFB74D) : Colors.white,
      ),
    );
  }

  // 提取通用的页面构建方法
  Widget _buildPageTemplate({
    required Widget icon,
    required String title,
    Widget? content,
    String? description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          if (content != null) ...[
            const SizedBox(height: 24),
            content,
          ],
          if (description != null) ...[
            const SizedBox(height: 24),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 16,
              ),
            ),
          ],
          const SizedBox(height: 40),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return _buildPageTemplate(
      icon: _buildIconContainer(
        icon: Icons.shield,
        backgroundColor: Colors.white,
      ),
      title: AppLocalizations.of(context)!.welcome,
      content: const Column(
        children: [
          Text(
            'Your Call Your Rule',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      description: AppLocalizations.of(context)!.onboardingWelcomeDescription,
    );
  }

  Widget _buildLanguagePage() {
    final localeState = ref.watch(localeProvider);
    final currentLocale = localeState.locale;
      final List<Map<String, dynamic>> supportedLocales = languages;

    return _buildPageTemplate(
      icon: _buildIconContainer(
        icon: Icons.language,
        backgroundColor: const Color(0xFF039BE5),
        size: 100,
        iconSize: 50,
      ),
      title: AppLocalizations.of(context)!.selectYourLanguage,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: 
        LanguageSelectionWidget(
          supportedLocales: supportedLocales,
          currentLocale: currentLocale,
          localeNotifier: ref.read(localeProvider.notifier),
          showCurrentLanguage: false,
        ),
      ),
      description: AppLocalizations.of(context)?.onboardingLanguageDescription ?? '',
    );
  }

  Widget _buildFeaturePage1() {
    return _buildPageTemplate(
      icon: _buildIconContainer(
        icon: Icons.contact_phone,
        backgroundColor: const Color(0xFFFF7043),
        size: 100,
        iconSize: 50,
      ),
      title: AppLocalizations.of(context)!.smartCallerId,
      content: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(
            Icons.phone_callback,
            size: 80,
            color: Colors.white,
          ),
        ),
      ),
      description: AppLocalizations.of(context)!.onboardingSmartCallerIdDescription,
    );
  }

  Widget _buildFeaturePage2() {
    return _buildPageTemplate(
      icon: _buildIconContainer(
        icon: Icons.block,
        backgroundColor: const Color(0xFFE53935),
        size: 100,
        iconSize: 50,
      ),
      title: AppLocalizations.of(context)!.powerfulSpamBlocking,
      content: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Icon(
            Icons.phonelink_erase,
            size: 80,
            color: Colors.white,
          ),
        ),
      ),
      description: AppLocalizations.of(context)!.onboardingPowerfulSpamBlockingDescription,
    );
  }

  Widget _buildPermissionsPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIconContainer(
            icon: Icons.verified_user,
            backgroundColor: const Color(0xFF43A047),
            size: 100,
            iconSize: 50,
          ),
          const SizedBox(height: 30),
          Text(
            AppLocalizations.of(context)!.grantNecessaryPermissions,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.onboardingPermissionsDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          // 权限列表
          _buildPermissionItem(
            icon: Icons.phone,
            title: AppLocalizations.of(context)!.phonePermission,
            description: AppLocalizations.of(context)!.phonePermissionDescription,
            color: const Color(0xFFFFB74D),
          ),
          const SizedBox(height: 16),
          _buildPermissionItem(
            icon: Icons.sms,
            title: AppLocalizations.of(context)!.smsPermission,
            description: AppLocalizations.of(context)!.smsPermissionDescription,
            color: const Color(0xFF039BE5),
          ),
          const SizedBox(height: 16),
          _buildPermissionItem(
            icon: Icons.contacts,
            title: AppLocalizations.of(context)!.contactsPermission,
            description: AppLocalizations.of(context)!.contactsPermissionDescription,
            color: const Color(0xFF43A047),
          ),
          const SizedBox(height: 16),
          _buildPermissionItem(
            icon: Icons.screen_lock_portrait,
            title: AppLocalizations.of(context)!.callScreeningPermission,
            description: AppLocalizations.of(context)!.callScreeningPermissionDescription,
            color: const Color(0xFFE53935),
          ),
          const SizedBox(height: 30),
          // 授权按钮
          ElevatedButton(
            onPressed: () async {
              final result = await CallScreeningPlugin.requestCallScreeningRole();
              if (!result && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.callScreeningPermissionNotGranted,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFFFB74D),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              AppLocalizations.of(context)!.grantPermissions,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 30),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPermissionItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
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

  Widget _buildCompletePage() {
    return _buildPageTemplate(
      icon: _buildIconContainer(
        icon: Icons.rocket_launch,
        backgroundColor: const Color(0xFFFFB74D),
        size: 100,
        iconSize: 50,
      ),
      title: AppLocalizations.of(context)!.ready,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF43A047).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle,
              color: Color(0xFF43A047),
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.allSettingsCompleted,
              style: const TextStyle(
                color: Color(0xFF43A047),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      description: AppLocalizations.of(context)!.onboardingCompleteDescription,
    );
  }
}