import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:pyro_telephony_hub/pyro_telephony_hub.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

class CallOverlayMockData {
  static CallerIdData mockCallerIdData() {
    return CallerIdData(
      phoneNumber: '0012345678900',
      countryName: 'United States',
      region: 'New York',
      carrier: 'Example Carrier',
      name: 'Example Name',
    );
  }

  static StirInfo mockStirInfoData() {
    return {
      'isVerified': true,
      'isNotVerified': false,
      'isFailed': false,
      'phoneNumber': '0012345678900',
    };
  }

  static SimInfo mockSimInfoData() {
    return {
      'carrierName': 'Example Carrier',
      'displayName': 'SIM 1',
      'iccId': '8901234567890123456',
      'countryIso': 'US',
      'phoneNumber': '0012345678900',
      'simSlotIndex': 0,
      'subscriptionId': 1,
    };
  }
}
