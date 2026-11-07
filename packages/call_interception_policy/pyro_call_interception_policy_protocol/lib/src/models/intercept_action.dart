import 'package:freezed_annotation/freezed_annotation.dart';

part 'intercept_action.freezed.dart';
part 'intercept_action.g.dart';

/// 纯数据驱动通话挂断/拦截动作领域值对象 (InterceptAction Value Object)
@freezed
abstract class InterceptAction with _$InterceptAction {
  const InterceptAction._();

  const factory InterceptAction({
    required String actionName,
  }) = _InterceptAction;

  static const InterceptAction endCall = InterceptAction(actionName: 'endCall');
  static const InterceptAction answerThenHangup = InterceptAction(actionName: 'answerThenHangup');
  static const InterceptAction silenceNoAnswer = InterceptAction(actionName: 'silenceNoAnswer');

  factory InterceptAction.fromJson(Map<String, dynamic> json) => _$InterceptActionFromJson(json);

  factory InterceptAction.fromMap(Map<String, dynamic> map) => InterceptAction.fromJson(map);

  Map<String, dynamic> toMap() => toJson();
}
