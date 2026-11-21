import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_sim_driver/pyro_sim_driver.dart';
import 'package:pyro_sim_driver/src/sim_api.g.dart';

class MockSimHostApi implements SimHostApi {
  bool simPresent = true;
  List<SimCardPayload> mockCards = [];
  NetworkInfoPayload? mockNetworkInfo;

  @override
  // ignore: non_constant_identifier_names
  final String pigeonVar_messageChannelSuffix = '';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<bool> hasSimCard() async => simPresent;

  @override
  Future<List<SimCardPayload>> getActiveSimCards() async => mockCards;

  @override
  Future<NetworkInfoPayload?> getNetworkInfo() async => mockNetworkInfo;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SimDriver tests', () {
    late MockSimHostApi mockHostApi;
    late SimDriver driver;

    setUp(() {
      mockHostApi = MockSimHostApi();
      driver = SimDriver(hostApi: mockHostApi);
    });

    tearDown(() {
      driver.dispose();
    });

    test('hasSimCard forwards to HostApi', () async {
      mockHostApi.simPresent = true;
      expect(await driver.hasSimCard(), isTrue);

      mockHostApi.simPresent = false;
      expect(await driver.hasSimCard(), isFalse);
    });

    test('getActiveSimCards correctly maps to SimCardEntity', () async {
      mockHostApi.mockCards = [
        SimCardPayload(
          subscriptionId: 1,
          simSlotIndex: 0,
          carrierName: 'China Mobile',
          displayName: 'CMCC',
          countryIso: 'CN',
          iccId: '898600000000',
          mccString: '460',
          mncString: '00',
          simPhoneNumber: '+8613800000000',
          isDataRoaming: false,
          isNetworkRoaming: false,
          state: 'ready',
        ),
      ];

      final cards = await driver.getActiveSimCards();
      expect(cards.length, equals(1));

      final card = cards.first;
      expect(card.subscriptionId, equals(1));
      expect(card.simSlotIndex, equals(0));
      expect(card.carrier.carrierName, equals('China Mobile'));
      expect(card.carrier.mcc, equals('460'));
      expect(card.carrier.mnc, equals('00'));
      expect(card.phoneNumber, equals('+8613800000000'));
      expect(card.state, equals(SimStateType.ready));
    });

    test('getSimBySlot finds corresponding slot card', () async {
      mockHostApi.mockCards = [
        SimCardPayload(subscriptionId: 10, simSlotIndex: 0),
        SimCardPayload(subscriptionId: 20, simSlotIndex: 1),
      ];

      final card0 = await driver.getSimBySlot(0);
      expect(card0, isNotNull);
      expect(card0!.subscriptionId, equals(10));

      final card1 = await driver.getSimBySlot(1);
      expect(card1, isNotNull);
      expect(card1!.subscriptionId, equals(20));

      final cardMissing = await driver.getSimBySlot(2);
      expect(cardMissing, isNull);
    });

    test('getNetworkInfo maps to NetworkInfoEntity', () async {
      mockHostApi.mockNetworkInfo = NetworkInfoPayload(
        networkOperatorName: 'China Unicom',
        networkOperator: '46001',
        networkType: 'LTE',
        isNetworkAvailable: true,
        isRoaming: false,
      );

      final info = await driver.getNetworkInfo();
      expect(info, isNotNull);
      expect(info!.networkOperatorName, equals('China Unicom'));
      expect(info.networkOperator, equals('46001'));
      expect(info.networkType, equals('LTE'));
      expect(info.isNetworkAvailable, isTrue);
      expect(info.isRoaming, isFalse);
      expect(info.generation, equals(NetworkGeneration.g4));
    });
  });
}
