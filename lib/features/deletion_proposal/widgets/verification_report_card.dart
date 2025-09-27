import 'package:flutter/material.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class VerificationReportCard extends StatelessWidget {
  final Map<String, dynamic> report;

  const VerificationReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.verificationReport,
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildReportItem(
              context,
              icon: Icons.security,
              label: AppLocalizations.of(context)!.finalRisk,
              value: report['finalRisk'] ?? 'N/A',
              valueColor: _getRiskColor(context, report['finalRisk']),
            ),
            _buildReportItem(
              context,
              icon: Icons.sim_card,
              label: AppLocalizations.of(context)!.simState,
              value: report['simState'] ?? 'N/A',
            ),
            _buildReportItem(
              context,
              icon: Icons.public,
              label: AppLocalizations.of(context)!.ipCountry,
              value: report['ipCountry'] ?? 'N/A',
            ),
            _buildReportItem(
              context,
              icon: Icons.network_cell,
              label: AppLocalizations.of(context)!.simCountry,
              value: report['simCountry'] ?? 'N/A',
            ),
            _buildReportItem(
              context,
              icon: Icons.airplanemode_active,
              label: AppLocalizations.of(context)!.isRoaming,
              value: (report['isRoaming'] ?? false).toString(),
            ),
            _buildReportItem(
              context,
              icon: Icons.verified_user,
              label: AppLocalizations.of(context)!.isNumberMatch,
              value: (report['isNumberMatch'] ?? false).toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem(BuildContext context, {required IconData icon, required String label, required String value, Color? valueColor}) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Text('$label:', style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          const Spacer(),
          Text(
            value,
            style: textTheme.bodyMedium?.copyWith(
              color: valueColor ?? Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRiskColor(BuildContext context, String? riskLevel) {
    switch (riskLevel?.toLowerCase()) {
      case 'verified':
        return Colors.green;
      case 'low':
        return Colors.blue;
      case 'medium':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Theme.of(context).colorScheme.onSurface;
    }
  }
}