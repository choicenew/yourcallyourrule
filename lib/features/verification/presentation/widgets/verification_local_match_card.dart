import 'package:flutter/material.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/features/home_elite/theme/elite_dopamine_theme.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

/// 本地通讯录与标签匹配卡片（合并 SearchPage 的本地能力）
class VerificationLocalMatchCard extends StatelessWidget {
  final Contact? matchedContact;
  final LabelPhoneEntry? matchedLabel;

  const VerificationLocalMatchCard({
    super.key,
    this.matchedContact,
    this.matchedLabel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFEDE8DF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.contacts_rounded,
                size: 18,
                color: EliteDopamineTheme.freshMint,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.contacts,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (matchedContact != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFE8F5E9),
                child: Icon(Icons.person_rounded, color: Color(0xFF2E7D32)),
              ),
              title: Text(
                matchedContact!.name,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(matchedContact!.phoneNumbers.join(', ')),
            ),
          if (matchedLabel != null)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFFFF3E0),
                child: Icon(Icons.label_rounded, color: Color(0xFFE65100)),
              ),
              title: Text(
                matchedLabel!.labelId,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: Text(l10n.tagLabel(matchedLabel!.labelId)),
            ),
        ],
      ),
    );
  }
}
