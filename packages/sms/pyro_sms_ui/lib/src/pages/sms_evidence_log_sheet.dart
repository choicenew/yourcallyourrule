import 'package:material_ui/material_ui.dart';
import 'package:pyro_sms_protocol/pyro_sms_protocol.dart';
import '../l10n/sms_localizations.dart';

/// Modal log sheet displaying captured SMS evidence samples and phishing link logs
class SmsEvidenceLogSheet extends StatelessWidget {
  final List<SmsEvidenceItem> logs;

  const SmsEvidenceLogSheet({
    super.key,
    this.logs = const [],
  });

  static Future<void> show(BuildContext context, {List<SmsEvidenceItem> logs = const []}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SmsEvidenceLogSheet(logs: logs),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = SmsLocalizations.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.evidenceLogsTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: logs.isEmpty
                ? Center(child: Text(l10n.noEvidenceLogsMessage))
                : ListView.separated(
                    itemCount: logs.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (ctx, idx) {
                      final log = logs[idx];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getRiskColor(log.riskLevel),
                          child: const Icon(Icons.security, color: Colors.white),
                        ),
                        title: Text('${log.message.sender} (${log.category.name})'),
                        subtitle: Text(
                          '${log.message.body}\n${log.takenAction.name} | ${(log.spamScore * 100).toStringAsFixed(1)}%',
                        ),
                        isThreeLine: true,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Color _getRiskColor(SmsRiskLevel level) {
    switch (level) {
      case SmsRiskLevel.critical:
        return Colors.red;
      case SmsRiskLevel.high:
        return Colors.orange;
      case SmsRiskLevel.medium:
        return Colors.amber;
      case SmsRiskLevel.low:
        return Colors.blue;
      case SmsRiskLevel.safe:
        return Colors.green;
    }
  }
}
