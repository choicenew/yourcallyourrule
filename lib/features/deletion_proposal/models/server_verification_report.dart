import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_verification_report.freezed.dart';
part 'server_verification_report.g.dart';

/// 强类型的服务器验证报告实体，用于替代手写的 Map<String, dynamic> 裸字符串。
@freezed
abstract class ServerVerificationReport with _$ServerVerificationReport {
  const factory ServerVerificationReport({
    required String simState,
    required String finalRisk,
    String? deviceId,
    @Default(false) bool isRoaming,
    String? simCountry,
    String? ipCountry,
    @Default(false) bool isNumberMatch,
    int? riskScore,
  }) = _ServerVerificationReport;

  factory ServerVerificationReport.fromJson(Map<String, dynamic> json) =>
      _$ServerVerificationReportFromJson(json);
}
