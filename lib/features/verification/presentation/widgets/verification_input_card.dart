import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 验证页面的号码与国家代码输入卡片
/// 完全国际化，支持东西方不同语言习惯，完整保留输入提示与指引
class VerificationInputCard extends StatelessWidget {
  final TextEditingController countryCodeController;
  final TextEditingController phoneNumberController;
  final bool isLoading;
  final VoidCallback onVerify;

  const VerificationInputCard({
    super.key,
    required this.countryCodeController,
    required this.phoneNumberController,
    required this.isLoading,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 国家代码输入框（全语言适配）
          TextField(
            controller: countryCodeController,
            decoration: InputDecoration(
              labelText: '${l10n.country} (ISO 3166-1 alpha-2)',
              labelStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
              ),
              hintText: 'US, CN, JP...',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black26),
              prefixIcon: const Icon(
                Icons.language_rounded,
                color: Color(0xFF2D9CDB),
                size: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFF2D9CDB), width: 1.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF7F5F0),
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
          ),
          const SizedBox(height: 14),

          // 电话号码输入框
          TextField(
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: l10n.enterPhoneNumber,
              labelStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                fontWeight: FontWeight.w700,
              ),
              hintText: l10n.enterPhoneNumberHint,
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black26),
              prefixIcon: const Icon(
                Icons.phone_rounded,
                color: EliteDopamineTheme.warmSunAmber,
                size: 20,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: EliteDopamineTheme.sunsetTangerine, width: 1.5),
              ),
              filled: true,
              fillColor: const Color(0xFFF7F5F0),
              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            ),
            onSubmitted: (_) => onVerify(),
          ),
          const SizedBox(height: 16),

          // 验证按钮
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : onVerify,
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.verified_rounded, size: 20),
              label: Text(
                isLoading ? l10n.fetchingCallerIdInfo : l10n.verify,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: EliteDopamineTheme.sunsetTangerine,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
