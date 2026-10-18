import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/call/stir_info.dart';
import 'package:yourcallyourrule/features/call/caller_id/core/extensions/phone_number_type_extension.dart';
import 'package:yourcallyourrule/features/call/caller_id/mock_data/caller_id_mock.dart';
import 'package:yourcallyourrule/features/call/live_activities/live_activity_config/live_notification_config.dart';
import 'package:yourcallyourrule/generated/app_localizations.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Notification Priority & STIR Wording Tests', () {
    testWidgets('Verify English & Chinese STIR wording in AppLocalizations', (WidgetTester tester) async {
      late AppLocalizations l10nEn;
      late AppLocalizations l10nZh;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
              l10nEn = AppLocalizations.of(context)!;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(l10nEn.stirVerified, equals('STIR Pass'));
      expect(l10nEn.stirNotVerified, equals('STIR Not Pass'));

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          home: Builder(
            builder: (context) {
              l10nZh = AppLocalizations.of(context)!;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(l10nZh.stirVerified, equals('STIR 通过'));
      expect(l10nZh.stirNotVerified, equals('STIR 未通过'));
    });

    testWidgets('Verify PhoneNumberTypeExtension returns localized string instead of raw enum name', (WidgetTester tester) async {
      late String translatedEn;
      late String translatedZh;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
              translatedEn = PhoneNumberType.fixedLineOrMobile.translated(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(translatedEn, equals('Fixed line or mobile'));
      expect(translatedEn, isNot(equals('fixedLineOrMobile')));

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('zh'),
          home: Builder(
            builder: (context) {
              translatedZh = PhoneNumberType.fixedLineOrMobile.translated(context);
              return const SizedBox();
            },
          ),
        ),
      );

      expect(translatedZh, equals('固定电话或移动电话'));
      expect(translatedZh, isNot(equals('fixedLineOrMobile')));
    });

    testWidgets('Verify notification detail priority ordering and conditional STIR display', (WidgetTester tester) async {
      late AppLocalizations l10n;

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('en'),
          home: Builder(
            builder: (context) {
              l10n = AppLocalizations.of(context)!;
              return const SizedBox();
            },
          ),
        ),
      );

      final mockData = CallerIdMockData.mockCallerIdData();
      final mockSimInfo = CallerIdMockData.mockSimInfoData();
      final stirInfoVerified = StirInfo(phoneNumber: '0012345678900', isVerified: true, isNotVerified: false, isFailed: false);
      final stirInfoUnverified = StirInfo(phoneNumber: '0012345678900', isVerified: false, isNotVerified: true, isFailed: false);

      const config = LiveNotificationConfig();

      List<String> buildDetails(StirInfo? stir, BuildContext context) {
        final List<String> details = [];
        if (config.count.visible && mockData.count > 0) {
          details.add(l10n.callerIdMarkedByCount(mockData.count));
        }
        if (config.simCard.visible && mockSimInfo.displayName != null && mockSimInfo.displayName!.isNotEmpty) {
          details.add(mockSimInfo.displayName!);
        }
        if (config.carrier.visible && mockData.carrier != null && mockData.carrier!.isNotEmpty) {
          details.add(mockData.carrier!);
        }
        if (config.location.visible && mockData.region != null && mockData.region!.isNotEmpty) {
          details.add(mockData.region!);
        }
        if (config.countryName.visible && mockData.countryName != null && mockData.countryName!.isNotEmpty) {
          details.add(mockData.countryName!);
        }
        if (config.numberType.visible && mockData.numberType != PhoneNumberType.unknown) {
          details.add(mockData.numberType.translated(context));
        }
        if (config.stir.visible && stir != null && stir.isVerified) {
          details.add(l10n.stirVerified);
        }
        return details;
      }

      final element = tester.element(find.byType(SizedBox));
      final verifiedDetails = buildDetails(stirInfoVerified, element);
      expect(verifiedDetails, equals([
        'Marked by 5',
        'SIM 1',
        'Example Carrier',
        'New York',
        'United States',
        'Fixed line or mobile',
        'STIR Pass',
      ]));

      // 未验证或无 STIR 数据时不出现 STIR 文本
      final unverifiedDetails = buildDetails(stirInfoUnverified, element);
      expect(unverifiedDetails.contains('STIR Pass'), isFalse);
      expect(unverifiedDetails.contains('STIR Not Pass'), isFalse);
      expect(unverifiedDetails, equals([
        'Marked by 5',
        'SIM 1',
        'Example Carrier',
        'New York',
        'United States',
        'Fixed line or mobile',
      ]));
    });
  });
}
