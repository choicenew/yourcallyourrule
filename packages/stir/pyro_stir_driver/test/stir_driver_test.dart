import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_stir_driver/pyro_stir_driver.dart';
import 'package:pyro_stir_driver/src/stir_api.g.dart';

class FakeStirHostApi implements StirHostApi {
  String? queriedNumber;

  @override
  // ignore: non_constant_identifier_names
  BinaryMessenger? get pigeonVar_binaryMessenger => null;

  @override
  // ignore: non_constant_identifier_names
  String get pigeonVar_messageChannelSuffix => '';

  @override
  Future<StirCheckResponse> checkStirStatus(String phoneNumber) async {
    queriedNumber = phoneNumber;
    return StirCheckResponse(
      phoneNumber: phoneNumber,
      status: 'PASSED',
      isVerified: true,
      isFailed: false,
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StirDriver Pigeon Tests', () {
    test('checkStirStatus returns strongly-typed StirResultEntity', () async {
      final fakeApi = FakeStirHostApi();
      final driver = StirDriver(hostApi: fakeApi);

      final result = await driver.checkStirStatus('+1234567890');

      expect(result, isNotNull);
      expect(result!.phoneNumber, equals('+1234567890'));
      expect(result.isVerified, isTrue);
      expect(result.isFailed, isFalse);
      expect(result.status.name, equals('passed'));
      expect(fakeApi.queriedNumber, equals('+1234567890'));
    });
  });
}
