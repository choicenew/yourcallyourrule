import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/core/router/app_router.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

import '../services/onboarding_service.dart';
import '../widgets/onboarding_top_bar.dart';
import '../widgets/onboarding_bottom_bar.dart';
import '../widgets/onboarding_welcome_card.dart';
import '../widgets/onboarding_language_card.dart';
import '../widgets/onboarding_caller_id_card.dart';
import '../widgets/onboarding_spam_block_card.dart';
import '../widgets/onboarding_permissions_card.dart';
import '../widgets/onboarding_ready_card.dart';

/// 应用引导主页面（100% 仿 InitialSetup 彻底解耦与模块化重构版）
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

  /// 统一处理 Onboarding 完成逻辑
  Future<void> _completeOnboardingFlow() async {
    final service = ref.read(onboardingServiceProvider);
    await service.completeOnboarding();
    if (!mounted) return;
    GoRouter.of(context).goNamed(AppRouter.home);
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
            OnboardingTopBar(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onSkip: _completeOnboardingFlow,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: const [
                  OnboardingWelcomeCard(),
                  OnboardingLanguageCard(),
                  OnboardingCallerIdCard(),
                  OnboardingSpamBlockCard(),
                  OnboardingPermissionsCard(),
                  OnboardingReadyCard(),
                ],
              ),
            ),
            OnboardingBottomBar(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onPrevious: _previousPage,
              onNext: _nextPage,
              onFinish: _completeOnboardingFlow,
            ),
          ],
        ),
      ),
    );
  }
}
