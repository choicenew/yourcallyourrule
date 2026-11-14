import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:yourcallyourrule/features/config/data/repositories/config_repository.dart';
import 'package:yourcallyourrule/features/call/call_overlay/configuration/fraud_alert_config.dart';
import 'package:yourcallyourrule/features/call/call_overlay/presentation/widgets/fraud_alert_config_widget.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

class FraudAlertSettingsPage extends ConsumerWidget {
  const FraudAlertSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).fraudAlerSettingTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            FraudAlertConfigWidget(),
          ],
        ),
      ),
    );
  }
}