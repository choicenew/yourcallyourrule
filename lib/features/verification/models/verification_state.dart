import 'package:pyro_caller_identity_protocol/pyro_caller_identity_protocol.dart';
import 'package:pyro_phone_contacts_protocol/pyro_phone_contacts_protocol.dart';
import 'package:pyro_phone_marking_protocol/pyro_phone_marking_protocol.dart';
import 'package:pyro_phone_lookup_plugin_protocol/pyro_phone_lookup_plugin_protocol.dart';

/// 号码验证状态数据模�?class VerificationState {
  final String phoneNumber;
  final String countryCode;
  final List<String> candidateCountries;
  final bool isInternational;
  final bool isLoading;
  final bool hasVerified;
  final CallerIdData? callerIdData;
  final Contact? matchedContact;
  final LabelPhoneEntry? matchedLabel;
  final PluginSourceData? pluginSourceData;
  final Map<String, bool> rulesResults;
  final String? errorMessage;

  const VerificationState({
    this.phoneNumber = '',
    this.countryCode = '',
    this.candidateCountries = const [],
    this.isInternational = false,
    this.isLoading = false,
    this.hasVerified = false,
    this.callerIdData,
    this.matchedContact,
    this.matchedLabel,
    this.pluginSourceData,
    this.rulesResults = const {},
    this.errorMessage,
  });

  VerificationState copyWith({
    String? phoneNumber,
    String? countryCode,
    List<String>? candidateCountries,
    bool? isInternational,
    bool? isLoading,
    bool? hasVerified,
    CallerIdData? callerIdData,
    Contact? matchedContact,
    LabelPhoneEntry? matchedLabel,
    PluginSourceData? pluginSourceData,
    Map<String, bool>? rulesResults,
    String? errorMessage,
  }) {
    return VerificationState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      candidateCountries: candidateCountries ?? this.candidateCountries,
      isInternational: isInternational ?? this.isInternational,
      isLoading: isLoading ?? this.isLoading,
      hasVerified: hasVerified ?? this.hasVerified,
      callerIdData: callerIdData ?? this.callerIdData,
      matchedContact: matchedContact ?? this.matchedContact,
      matchedLabel: matchedLabel ?? this.matchedLabel,
      pluginSourceData: pluginSourceData ?? this.pluginSourceData,
      rulesResults: rulesResults ?? this.rulesResults,
      errorMessage: errorMessage,
    );
  }
}
