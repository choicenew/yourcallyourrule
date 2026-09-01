import 'package:yourcallyourrule/core/entities/caller_id_data.dart';
import 'package:yourcallyourrule/core/entities/contact/contact_entry.dart';
import 'package:yourcallyourrule/core/entities/label/label_phone_entry.dart';
import 'package:yourcallyourrule/core/entities/plugin/plugin_source_data.dart';

/// 号码验证状态数据模型
class VerificationState {
  final String phoneNumber;
  final String countryCode;
  final bool isLoading;
  final bool hasVerified;
  final CallerIdData? callerIdData;
  final Contact? matchedContact;
  final LabelPhoneEntry? matchedLabel;
  final PluginSourceData? pluginSourceData;
  final Map<String, dynamic> legacyPluginData;
  final Map<String, bool> rulesResults;
  final String? errorMessage;

  const VerificationState({
    this.phoneNumber = '',
    this.countryCode = 'US',
    this.isLoading = false,
    this.hasVerified = false,
    this.callerIdData,
    this.matchedContact,
    this.matchedLabel,
    this.pluginSourceData,
    this.legacyPluginData = const {},
    this.rulesResults = const {},
    this.errorMessage,
  });

  VerificationState copyWith({
    String? phoneNumber,
    String? countryCode,
    bool? isLoading,
    bool? hasVerified,
    CallerIdData? callerIdData,
    Contact? matchedContact,
    LabelPhoneEntry? matchedLabel,
    PluginSourceData? pluginSourceData,
    Map<String, dynamic>? legacyPluginData,
    Map<String, bool>? rulesResults,
    String? errorMessage,
  }) {
    return VerificationState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      isLoading: isLoading ?? this.isLoading,
      hasVerified: hasVerified ?? this.hasVerified,
      callerIdData: callerIdData ?? this.callerIdData,
      matchedContact: matchedContact ?? this.matchedContact,
      matchedLabel: matchedLabel ?? this.matchedLabel,
      pluginSourceData: pluginSourceData ?? this.pluginSourceData,
      legacyPluginData: legacyPluginData ?? this.legacyPluginData,
      rulesResults: rulesResults ?? this.rulesResults,
      errorMessage: errorMessage,
    );
  }
}
