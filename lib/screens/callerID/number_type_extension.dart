// phone_number_type_extension.dart
import 'package:dlibphonenumber/dlibphonenumber.dart';
import 'package:flutter/material.dart'; // 导入BuildContext
import 'translation_utils.dart';

extension PhoneNumberTypeExtension on PhoneNumberType {
  String translated(BuildContext context) {
    return translatePhoneNumberType(this, context);
  }
}