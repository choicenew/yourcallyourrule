/// 用于表示UI元素在屏幕上的位置
class PositionOffset {
  final double dx;
  final double dy;

  const PositionOffset({required this.dx, required this.dy});

  /// 从Flutter的Offset创建
  factory PositionOffset.fromOffset(dynamic offset) {
    return PositionOffset(dx: offset.dx, dy: offset.dy);
  }

  /// 转换为JSON
  Map<String, dynamic> toJson() {
    return {
      'dx': dx,
      'dy': dy,
    };
  }

  /// 从JSON创建实例
  factory PositionOffset.fromJson(Map<String, dynamic> json) {
    return PositionOffset(
      dx: (json['dx'] as num).toDouble(),
      dy: (json['dy'] as num).toDouble(),
    );
  }

  /// 复制并修改部分属性
  PositionOffset copyWith({double? dx, double? dy}) {
    return PositionOffset(
      dx: dx ?? this.dx,
      dy: dy ?? this.dy,
    );
  }
}