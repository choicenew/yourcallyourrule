import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

import '../services/notification_frequency_service.dart';

class NotificationFrequencySettings extends ConsumerWidget {
  const NotificationFrequencySettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frequencyService = ref.watch(notificationFrequencyServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notificationFrequencyTitle),
      ),
      body: FutureBuilder<int>(
        future: frequencyService.getNotificationFrequency(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final frequency = snapshot.data ?? 24;

          return ListTile(
            title: Text(AppLocalizations.of(context)!.notificationFrequencyHours),
            trailing: DropdownButton<int>(
              value: frequency,
              items: [24, 48, 72].map((hours) {
                return DropdownMenuItem<int>(
                  value: hours,
                  child: Text(AppLocalizations.of(context)!.hoursDuration(hours)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  frequencyService.setNotificationFrequency(value);
                }
              },
            ),
          );
        },
      ),
    );
  }
}