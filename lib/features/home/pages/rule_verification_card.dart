import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';
import 'package:yourcallyourrule/presentation/verification_page.dart';

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
    return Card(
      color:
          Theme.of(context).brightness == Brightness.dark
              ? Colors.pink.withOpacity(0.2)
              : Colors.pink[200], // <--- Adapt to theme
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.ruleVerification,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      prefixIcon: const Icon(Icons.phone),
                      prefixIconColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        // 设置边框为半透明白色
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      // --- 修改点 6: 聚焦时边框的颜色（推荐添加）---
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        // 设置聚焦时边框为纯白色，并加粗
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      // 确保 enabledBorder 样式也一致，防止颜色跳变
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    // 为了更好的可见性，输入文字的颜色也建议修改
                    style: const TextStyle(color: Colors.black87),
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
                    backgroundColor: Theme.of(context).primaryColor,
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
