/// 通话控制动作类型枚举
enum CallActionType {
  allow('allow'),
  reject('reject'),
  silence('silence'),
  answerThenHangup('answerThenHangup'),
  voicemail('voicemail'),
  answer('answer'),
  hangup('hangup');

  final String code;
  const CallActionType(this.code);

  String toCode() => code;

  static CallActionType fromString(String code) {
    switch (code) {
      case 'allow':
        return CallActionType.allow;
      case 'reject':
        return CallActionType.reject;
      case 'silence':
        return CallActionType.silence;
      case 'answerThenHangup':
        return CallActionType.answerThenHangup;
      case 'voicemail':
        return CallActionType.voicemail;
      case 'answer':
        return CallActionType.answer;
      case 'hangup':
        return CallActionType.hangup;
      default:
        return CallActionType.allow;
    }
  }
}
