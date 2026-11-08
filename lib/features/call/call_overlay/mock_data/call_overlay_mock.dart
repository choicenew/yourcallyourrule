import 'package:dlibphonenumber/enums/phone_number_type.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_telephony_protocol/pyro_telephony_protocol.dart';
import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:yourcallyourrule/features/common/value_objects/phone_number.dart';

class CallOverlayMockData {
  static CallerIdData mockCallerIdData() {
    return CallerIdData(
      id: '12345678900',
      phoneNumber: PhoneNumber.fromString('0012345678900'),
      countryName: 'United States',
      region: 'New York',
      carrier: 'Example Carrier',
      numberType: PhoneNumberType.fixedLineOrMobile,
      labels: [const Label(label: 'Other')],
      name: 'Example Name',
      avatar: 'assets/avatars/Other.png',
      count: 5,
    );
  }

  static StirInfo mockStirInfoData() {
    return StirInfo(
      isVerified: true,
      isNotVerified: false,
      isFailed: false,
      phoneNumber: '0012345678900',
    );
  }

  static SimInfo mockSimInfoData() {
    return SimInfo(
      carrierName: 'Example Carrier',
      displayName: 'SIM 1',
      iccId: '8901234567890123456',
      countryIso: 'US',
      phoneNumber: '0012345678900',
      simSlotIndex: 0,
      subscriptionId: 1,
      mccString: '310',
      mncString: '410',
      simPhoneNumber: '0011234567890',
      callType: "audio",
    );
  }
}

/// 兼容别名
typedef CallerIdMockData = CallOverlayMockData;