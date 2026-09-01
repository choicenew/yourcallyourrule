import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/features/verification/presentation/pages/verification_page.dart';

class RuleVerificationCard extends StatefulWidget {
  const RuleVerificationCard({super.key});

  @override
  State<RuleVerificationCard> createState() => _RuleVerificationCardState();
}

class _RuleVerificationCardState extends State<RuleVerificationCard> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      color: isDark ? primaryColor.withOpacity(0.15) : primaryColor.withOpacity(0.08), // <--- Adapt to theme
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  size: 20,
                  color: primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.ruleVerification,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(
                            context,
                          )!.enterPhoneNumberToVerify,
                      prefixIcon: Icon(Icons.phone, color: primaryColor),
                      prefixIconColor: primaryColor,
                      filled: true,
                      fillColor: isDark ? Colors.grey[850] : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        // 设置边框为半透明白色
                        borderSide: BorderSide(
                          color: primaryColor.withOpacity(0.3),
                        ),
                      ),
                      // --- 修改点 6: 聚焦时边框的颜色（推荐添加）---
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        // 设置聚焦时边框为纯白色，并加粗
                        borderSide: BorderSide(
                          color: primaryColor,
                          width: 2.0,
                        ),
                      ),
                      // 确保 enabledBorder 样式也一致，防止颜色跳变
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: primaryColor.withOpacity(0.3),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    // 为了更好的可见性，输入文字的颜色也建议修改
                    style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => VerificationPage(
                              initialPhoneNumber: _phoneController.text,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.verify,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
