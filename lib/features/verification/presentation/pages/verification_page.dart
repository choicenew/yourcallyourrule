import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:yourcallyourrule/ads/ad_manager.dart';
import 'package:yourcallyourrule/ads/adwidgets/native_ads.dart';
import 'package:yourcallyourrule/ads/google_ad.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/features/verification/presentation/widgets/verification_caller_id_card.dart';
import 'package:yourcallyourrule/features/verification/presentation/widgets/verification_decision_hero.dart';
import 'package:yourcallyourrule/features/verification/presentation/widgets/verification_input_card.dart';
import 'package:yourcallyourrule/features/verification/presentation/widgets/verification_local_match_card.dart';
import 'package:yourcallyourrule/features/verification/presentation/widgets/verification_plugin_card.dart';
import 'package:yourcallyourrule/features/verification/presentation/widgets/verification_rules_diagnostics_card.dart';
import 'package:yourcallyourrule/features/verification/models/verification_state.dart';
import 'package:yourcallyourrule/features/verification/providers/verification_provider.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 号码验证与安全体检主页面
/// 彻底解耦：仅负责 UI 拼装与状态绑定，所有 Service 和计算均由 VerificationNotifier 承接
class VerificationPage extends ConsumerStatefulWidget {
  final String? initialPhoneNumber;
  const VerificationPage({super.key, this.initialPhoneNumber});

  @override
  ConsumerState<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends ConsumerState<VerificationPage> {
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _countryCodeController;

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _countryCodeController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final extra = GoRouterState.of(context).extra;
      String? targetNumber;

      if (extra != null && extra is String && extra.trim().isNotEmpty) {
        targetNumber = extra.trim();
      } else if (widget.initialPhoneNumber != null &&
          widget.initialPhoneNumber!.trim().isNotEmpty) {
        targetNumber = widget.initialPhoneNumber!.trim();
      }

      ref
          .read(verificationProvider.notifier)
          .initLocaleAndNumber(initialNumber: targetNumber)
          .then((_) {
        if (mounted) {
          final state = ref.read(verificationProvider);
          _countryCodeController.text = state.countryCode;
          if (state.phoneNumber.isNotEmpty) {
            _phoneNumberController.text = state.phoneNumber;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _countryCodeController.dispose();
    super.dispose();
  }

  void _handleVerify() {
    final notifier = ref.read(verificationProvider.notifier);
    notifier.updateCountryCode(_countryCodeController.text);
    notifier.verifyNumber(_phoneNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final verificationState = ref.watch(verificationProvider);
    final notifier = ref.read(verificationProvider.notifier);

    // 监听错误提示
    ref.listen<VerificationState>(verificationProvider, (prev, next) {
      if (next.errorMessage != null && next.errorMessage != prev?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    return Scaffold(
      backgroundColor: EliteDopamineTheme.warmCanvasBackground,
      appBar: AppBar(
        title: Text(
          l10n.smartCallerId,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Colors.black87,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            const SizedBox(height: 12),
            VerificationInputCard(
              countryCodeController: _countryCodeController,
              phoneNumberController: _phoneNumberController,
              candidateCountries: verificationState.candidateCountries,
              selectedCountry: verificationState.countryCode,
              isInternational: verificationState.isInternational,
              isLoading: verificationState.isLoading,
              onCountrySelected: (code) {
                _countryCodeController.text = code;
                notifier.selectCountry(code);
              },
              onVerify: _handleVerify,
            ),
            const SizedBox(height: 16),
            if (verificationState.hasVerified) ...[
              VerificationDecisionHero(
                verificationResults: verificationState.rulesResults,
              ),
              const SizedBox(height: 16),
              if (verificationState.callerIdData != null) ...[
                VerificationCallerIdCard(
                  callerIdData: verificationState.callerIdData!,
                  fallbackPhoneNumber: _phoneNumberController.text,
                  onTestOverlay: notifier.testOverlay,
                  onCloseOverlay: notifier.closeOverlay,
                  onTestLiveActivity: notifier.testLiveActivity,
                  onTestNotification: notifier.testNotification,
                  onTestDefaultMode: notifier.testDefaultDisplayMode,
                ),
                const SizedBox(height: 16),
              ],
              if (verificationState.matchedContact != null ||
                  verificationState.matchedLabel != null) ...[
                VerificationLocalMatchCard(
                  matchedContact: verificationState.matchedContact,
                  matchedLabel: verificationState.matchedLabel,
                ),
                const SizedBox(height: 16),
              ],
              VerificationRulesDiagnosticsCard(
                verificationResults: verificationState.rulesResults,
              ),
              const SizedBox(height: 16),
              if (verificationState.pluginSourceData != null ||
                  verificationState.legacyPluginData.isNotEmpty) ...[
                VerificationPluginCard(
                  pluginSourceData: verificationState.pluginSourceData,
                  legacyPluginData: verificationState.legacyPluginData,
                ),
                const SizedBox(height: 16),
              ],
            ],
            const GoogleAdWidget(adInfo: AdManager.adaptiveBannerAd),
            const SizedBox(height: 14),
            nativeAdWidgetMedium(adWidth: 320, adHeight: 390),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
