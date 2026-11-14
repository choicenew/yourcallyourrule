import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/common/router/app_router.dart';
import 'package:yourcallyourrule/features/language/provider/language_provider.dart';

import 'package:yourcallyourrule/features/onboarding/services/onboarding_service.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_top_bar.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_bottom_bar.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_welcome_card.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_language_card.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_caller_id_card.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_spam_block_card.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_permissions_card.dart';
import 'package:yourcallyourrule/features/onboarding/widgets/onboarding_ready_card.dart';

/// 应用引导主页面
class OnboardingPage extends ConsumerStatefulWidget {
  final VoidCallback? onComplete;
  const OnboardingPage({super.key, this.onComplete});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 6;

  @override
  void initState() {
    super.initState();
  }

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

  Future<void> _completeOnboardingFlow() async {
    final service = ref.read(onboardingServiceProvider);
    await service.completeOnboarding();

    if (widget.onComplete != null) {
      widget.onComplete!();
    } else {
      if (!mounted) return;
      GoRouter.of(context).goNamed(AppRouter.initialSetup);
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
                children: [
                  const OnboardingWelcomeCard(),
                  const OnboardingLanguageCard(),
                  const OnboardingCallerIdCard(),
                  const OnboardingSpamBlockCard(),
                  const OnboardingPermissionsCard(),
                  const OnboardingReadyCard(),
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
