import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourcallyourrule/features/language/widgets/language_selection_widget.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';
import 'package:yourcallyourrule/features/caller_id/services/call_screen_plugin.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 应用引导页面
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
      // 最后一页，跳转到主页
      Navigator.of(context).pushReplacementNamed('/home');
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
    Navigator.of(context).pushReplacementNamed('/home');
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
              // 顶部进度条和跳过按钮
              _buildTopBar(),
              
              // 页面内容
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
              
              // 底部导航按钮
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
              color: Colors.white.withValues(alpha:0.2),
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
                  backgroundColor: Colors.white.withValues(alpha:0.2),
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
                  child: Text(AppLocalizations.of(context)!.previousStep, style: const TextStyle(fontSize: 16)),
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
              _currentPage == _totalPages - 1 ? AppLocalizations.of(context)!.startUsing : AppLocalizations.of(context)!.nextStep,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _totalPages; i++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == _currentPage ? Colors.white : Colors.white.withValues(alpha:0.3),
          ),
        ),
      );
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: indicators);
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.shield,
              size: 60,
              color: Color(0xFFFFB74D),
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          Text(
            AppLocalizations.of(context)!.welcome,
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 副标题
          const Text(
            'Your Call Your Rule',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          
          // 描述
          Text(
            AppLocalizations.of(context)!.onboardingWelcomeDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha:0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildLanguagePage() {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    final currentLocale = localeProvider.locale;
    
    // 支持的语言列表
    final supportedLocales = [
      {'name': '简体中文', 'code': const Locale('zh', 'CN'), 'flag': 'CN'},
      {'name': 'English', 'code': const Locale('en', 'US'), 'flag': 'US'},
      {'name': '日本語', 'code': const Locale('ja', 'JP'), 'flag': 'JP'},
      {'name': '한국어', 'code': const Locale('ko', 'KR'), 'flag': 'KR'},
      {'name': 'Français', 'code': const Locale('fr', 'FR'), 'flag': 'FR'},
      {'name': 'Deutsch', 'code': const Locale('de', 'DE'), 'flag': 'DE'},
      {'name': 'Español', 'code': const Locale('es', 'ES'), 'flag': 'ES'},
    ];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF039BE5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.language,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          
          // 标题
          Text(
            AppLocalizations.of(context)!.selectYourLanguage,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          
          // 使用LanguageSelectionWidget组件
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: LanguageSelectionWidget(
              supportedLocales: supportedLocales,
              currentLocale: currentLocale,
              localeProvider: localeProvider,
              showCurrentLanguage: false,
            ),
          ),
          const SizedBox(height: 20),
          
          // 描述
          Text(
            AppLocalizations.of(context)!.onboardingLanguageDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha:0.9), fontSize: 16),
          ),
          const SizedBox(height: 30),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildFeaturePage1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFFF7043),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.contact_phone,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          Text(
            AppLocalizations.of(context)!.smartCallerId,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // 功能图片
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.2),
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
          const SizedBox(height: 24),
          
          // 描述
          Text(
            AppLocalizations.of(context)!.onboardingSmartCallerIdDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha:0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildFeaturePage2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFE53935),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.block,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          Text(
            AppLocalizations.of(context)!.powerfulSpamBlocking,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // 功能图片
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha:0.2),
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
          const SizedBox(height: 24),
          
          // 描述
          Text(
            AppLocalizations.of(context)!.onboardingPowerfulSpamBlockingDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha:0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildPermissionsPage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF43A047),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.verified_user,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          
          // 标题
          Text(
            AppLocalizations.of(context)!.grantNecessaryPermissions,
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          // 描述
          Text(
            AppLocalizations.of(context)!.onboardingPermissionsDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha:0.9), fontSize: 16),
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
              // 请求通话筛选权限
              final result = await CallScreeningPlugin.requestCallScreeningRole();
              
              // 检查权限结果
              if (!result && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(AppLocalizations.of(context)!.callScreeningPermissionNotGranted),
                ));
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
            child: Text(AppLocalizations.of(context)!.grantPermissions, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(height: 30),
          
          // 页面指示器
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
        color: Colors.white.withValues(alpha:0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha:0.2),
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
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: TextStyle(color: Colors.white.withValues(alpha:0.7), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletePage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 图标
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFFFFB74D),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.rocket_launch,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 40),
          
          // 标题
          Text(
            AppLocalizations.of(context)!.ready,
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // 成功提示
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF43A047).withValues(alpha:0.2),
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
                  style: const TextStyle(color: Color(0xFF43A047), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // 描述
          Text(
            AppLocalizations.of(context)!.onboardingCompleteDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withValues(alpha:0.9), fontSize: 16),
          ),
          const SizedBox(height: 40),
          
          // 页面指示器
          _buildPageIndicator(),
        ],
      ),
    );
  }
}