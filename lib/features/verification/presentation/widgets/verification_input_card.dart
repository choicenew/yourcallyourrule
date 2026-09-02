import 'package:flutter/material.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 验证页面的号码与国家代码输入卡片
/// 支持：
/// 1. 国际号码（+ 或 00 开头）自动隐去国家选择框，直达数据结果；
/// 2. 纯本地号码展示按优先级排序的候选国家胶囊条（SIM1/SIM2/同步国家/系统地区），支持一键无缝切换与手动输入。
class VerificationInputCard extends StatefulWidget {
  final TextEditingController countryCodeController;
  final TextEditingController phoneNumberController;
  final List<String> candidateCountries;
  final String selectedCountry;
  final bool isInternational;
  final bool isLoading;
  final ValueChanged<String> onCountrySelected;
  final VoidCallback onVerify;

  const VerificationInputCard({
    super.key,
    required this.countryCodeController,
    required this.phoneNumberController,
    required this.candidateCountries,
    required this.selectedCountry,
    required this.isInternational,
    required this.isLoading,
    required this.onCountrySelected,
    required this.onVerify,
  });

  @override
  State<VerificationInputCard> createState() => _VerificationInputCardState();
}

class _VerificationInputCardState extends State<VerificationInputCard> {
  bool _showManualCountryInput = false;

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
          // 场景一：纯本地号码 -> 展示顶部多区域候选胶囊条与手动扩展
          if (!widget.isInternational) ...[
            Row(
              children: [
                Icon(
                  Icons.public_rounded,
                  size: 16,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 6),
                Text(
                  l10n.country,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    setState(() {
                      _showManualCountryInput = !_showManualCountryInput;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _showManualCountryInput ? Icons.close_rounded : Icons.edit_rounded,
                          size: 13,
                          color: const Color(0xFF2D9CDB),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _showManualCountryInput ? l10n.cancel : l10n.edit,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D9CDB),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 候选国家胶囊条
            if (widget.candidateCountries.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: widget.candidateCountries.map((countryCode) {
                    final isSelected = widget.selectedCountry.toUpperCase() == countryCode.toUpperCase();
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(
                          countryCode,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: EliteDopamineTheme.sunsetTangerine,
                        backgroundColor: const Color(0xFFF7F5F0),
                        side: BorderSide(
                          color: isSelected
                              ? EliteDopamineTheme.sunsetTangerine
                              : const Color(0xFFEDE8DF),
                          width: 1.1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        showCheckmark: false,
                        onSelected: (selected) {
                          if (selected) {
                            widget.onCountrySelected(countryCode);
                          }
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),

            // 手动输入国家代码区域（点击编辑时展开）
            if (_showManualCountryInput) ...[
              const SizedBox(height: 10),
              TextField(
                controller: widget.countryCodeController,
                decoration: InputDecoration(
                  labelText: '${l10n.country} (ISO 3166-1 alpha-2)',
                  labelStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w700,
                  ),
                  hintText: 'US, CN, HK, JP...',
                  hintStyle: const TextStyle(fontSize: 12, color: Colors.black26),
                  prefixIcon: const Icon(
                    Icons.language_rounded,
                    color: Color(0xFF2D9CDB),
                    size: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFEDE8DF), width: 1.1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF2D9CDB), width: 1.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFF7F5F0),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                ),
                onSubmitted: (val) {
                  if (val.trim().isNotEmpty) {
                    widget.onCountrySelected(val.trim().toUpperCase());
                  }
                },
              ),
            ],
            const SizedBox(height: 14),
          ],

          // 电话号码输入框
          TextField(
            controller: widget.phoneNumberController,
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
              suffixIcon: widget.isInternational
                  ? Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: EliteDopamineTheme.freshMint.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.public_rounded,
                            size: 12,
                            color: EliteDopamineTheme.freshMint,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.selectedCountry.isNotEmpty ? widget.selectedCountry : 'INTL',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: EliteDopamineTheme.freshMint,
                            ),
                          ),
                        ],
                      ),
                    )
                  : null,
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
            onSubmitted: (_) => widget.onVerify(),
          ),
          const SizedBox(height: 16),

          // 验证按钮
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: widget.isLoading ? null : widget.onVerify,
              icon: widget.isLoading
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
                widget.isLoading ? l10n.fetchingCallerIdInfo : l10n.verify,
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
