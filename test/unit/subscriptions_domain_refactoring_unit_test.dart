import 'package:flutter_test/flutter_test.dart';
import 'package:yourcallyourrule/core/entities/sms/sms_subscription.dart';
import 'package:yourcallyourrule/core/entities/subscription/contact_subscription.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription.dart';
import 'package:yourcallyourrule/core/entities/subscription/subscription_table_type.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';
import 'package:yourcallyourrule/core/value_objects/url.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Subscription 订阅表类型与反序列化测试', () {
    test('1. SubscriptionTableType 枚举解析', () {
      expect(SubscriptionTableType.fromString('phone'), equals(SubscriptionTableType.phone));
      expect(SubscriptionTableType.fromString('sms'), equals(SubscriptionTableType.sms));
      expect(SubscriptionTableType.fromString('contact'), equals(SubscriptionTableType.contact));
      expect(SubscriptionTableType.fromString(null), equals(SubscriptionTableType.phone));
    });

    test('2. Subscription 电话订阅默认类型绑定', () {
      final now = DateTime(2026, 10, 15);
      final sub = Subscription(
        id: 'sub_1',
        name: 'Phone Rules Feed',
        url: Url.fromString('https://example.com/phone.json'),
        lastUpdated: now,
      );

      expect(sub.tableType, equals(SubscriptionTableKeys.phone));
      expect(sub.isEnabled, isTrue);
      expect(sub.toMap()['tableType'], equals('phone'));
    });

    test('3. SmsSubscription 短信订阅默认类型绑定', () {
      final now = DateTime(2026, 10, 15);
      final smsSub = SmsSubscription(
        id: 'sub_2',
        name: 'SMS Rules Feed',
        url: Url.fromString('https://example.com/sms.json'),
        lastUpdated: now,
      );

      expect(smsSub.tableType, equals(SubscriptionTableKeys.sms));
      expect(smsSub.action, equals(RuleAction.block));
      expect(smsSub.toMap()['tableType'], equals('sms'));
    });

    test('4. ContactSubscription 联系人订阅默认类型绑定', () {
      final now = DateTime(2026, 10, 15);
      final contactSub = ContactSubscription(
        id: 'sub_3',
        name: 'Contacts Feed',
        url: Url.fromString('https://example.com/contacts.vcf'),
        lastUpdated: now,
      );

      expect(contactSub.tableType, equals(SubscriptionTableKeys.contact));
      expect(contactSub.toMap()['tableType'], equals('contact'));
    });
  });
}
