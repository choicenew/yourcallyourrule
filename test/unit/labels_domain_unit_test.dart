import 'package:flutter_test/flutter_test.dart';

import 'package:yourcallyourrule/common/utils/predefined_labels.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/label/predefined_label_entry.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';
import 'package:yourcallyourrule/core/value_objects/phone_number.dart';
import 'package:yourcallyourrule/core/value_objects/rule_action.dart';

/// Labels 标签领域模型与插件联动单元测试 (Labels Domain Unit Test)
/// 覆盖维度：
/// 1. PredefinedLabel 预定义标签实体的工厂构造与标准 ID 生成
/// 2. LabelPhoneEntry 电话号码标签条目与 RuleAction 强类型的序列化对称性
/// 3. PluginSourceData predefinedLabel 标签匹配与预定义标签解包
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('🏷️ Labels 标签领域模型与数据流联动单元测试', () {
    
    test('1. 验证 PredefinedLabel 实体创建与 ID 生成机制', () {
      final label = PredefinedLabel.create('Spam Likely');
      
      expect(label.text, equals('Spam Likely'));
      expect(label.id, equals('spam_likely')); // 自动转换为下划线 slug ID
      
      final customLabel = PredefinedLabel.create(
        'Fraud Scam Likely',
        icon: 'assets/icons/scam.png',
        avatar: 'assets/avatars/scam.png',
      );
      
      expect(customLabel.id, equals('fraud_scam_likely'));
      expect(customLabel.icon, equals('assets/icons/scam.png'));
    });

    test('2. 验证 LabelPhoneEntry 实体与 RuleAction 强类型绑定与序列化', () {
      final entry = LabelPhoneEntry(
        id: 'label_entry_001',
        phoneNumber: const PhoneNumber('+12026308598'),
        labelId: 'spam_likely',
        name: 'Telemarketer John',
        action: RuleAction.block,
      );

      expect(entry.phoneNumber.value, equals('+12026308598'));
      expect(entry.labelId, equals('spam_likely'));
      expect(entry.action, equals(RuleAction.block));

      final map = entry.toMap();
      expect(map['labelId'], equals('spam_likely'));
      expect(map['action'], equals('block'));

      final restored = LabelPhoneEntry.fromMap(map);
      expect(restored.phoneNumber.value, equals('+12026308598'));
      expect(restored.action, equals(RuleAction.block));
    });

    test('3. 验证 36 个预定义系统标签包含完整性', () {
      expect(predefinedLabels.length, equals(36));
      
      final labelTexts = predefinedLabels.map((m) => m['text']).toList();
      expect(labelTexts, contains('Fraud Scam Likely'));
      expect(labelTexts, contains('Spam Likely'));
      expect(labelTexts, contains('Telemarketing'));
      expect(labelTexts, contains('Robocall'));
      expect(labelTexts, contains('Delivery'));
    });

    test('4. 验证 PluginSourceData 与 PredefinedLabel 数据绑定解包', () {
      final pluginData = PluginSourceData.fromMap({
        'phoneNumber': '+12026308598',
        'predefinedLabel': 'Fraud Scam Likely',
        'action': 'block',
        'name': 'Scam Reporter',
      });

      expect(pluginData.phoneNumber, equals('+12026308598'));
      expect(pluginData.predefinedLabel, equals('Fraud Scam Likely'));
      expect(pluginData.action, equals(RuleAction.block));

      // 验证能够匹配到系统预定义标签
      final matchedPredefined = predefinedLabels.firstWhere(
        (m) => m['text'] == pluginData.predefinedLabel,
        orElse: () => {},
      );

      expect(matchedPredefined, isNotEmpty);
      expect(matchedPredefined['text'], equals('Fraud Scam Likely'));
    });
  });
}
