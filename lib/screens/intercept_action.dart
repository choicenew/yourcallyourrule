

// 定义枚举类型
enum InterceptAction { endCall, answerThenHangup, silenceNoAnswer }

// 定义枚举值对应的标签
const Map<InterceptAction, String> interceptActionLabels = {
  InterceptAction.endCall: 'endCall',
  InterceptAction.answerThenHangup: 'answerThenHangup',
  InterceptAction.silenceNoAnswer: 'silenceNoAnswer',
};