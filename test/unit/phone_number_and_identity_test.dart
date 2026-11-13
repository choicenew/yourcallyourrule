import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_phone_caller_identity_protocol/pyro_phone_caller_identity_protocol.dart';
import 'package:pyro_phone_location_protocol/pyro_phone_location_protocol.dart';

void main() {
  group('📞 CallerIdData & Phone Location 单元测试套件', () {
    test('1. 验证 CallerIdData 强类型实体创建与默认字段', () {
      final data = const CallerIdData(
        phoneNumber: '+8613800138000',
        name: '张三 (测试中介)',
        region: '广东广州',
        countryName: '中国',
        carrier: '中国移动',
        labels: ['推销电话', '房产中介'],
        localCount: 5,
        pluginCount: 2,
        remoteCount: 1,
      );

      expect(data.phoneNumber, equals('+8613800138000'));
      expect(data.name, equals('张三 (测试中介)'));
      expect(data.region, equals('广东广州'));
      expect(data.labels.length, equals(2));
      expect(data.labels, contains('推销电话'));
      expect(data.localCount, equals(5));
    });

    test('2. 验证 PhoneLocationEntry 归属地数据解析', () {
      final location = const PhoneLocationEntry(
        id: 'loc_1',
        phoneNumber: '+8615662327825',
        region: '山东济南',
        countryName: '中国',
        carrier: '中国联通',
        numberType: '1',
      );

      expect(location.id, equals('loc_1'));
      expect(location.phoneNumber, equals('+8615662327825'));
      expect(location.region, equals('山东济南'));
      expect(location.carrier, equals('中国联通'));
      expect(location.numberType, equals('1'));
    });
  });
}
