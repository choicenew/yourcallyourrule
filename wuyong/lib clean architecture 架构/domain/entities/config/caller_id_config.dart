/// 来电显示配置实体
class CallerIdConfig {
  final String backgroundColor;
  final String textColor;
  final double fontSize;
  final double borderRadius;
  final double opacity;
  final String position;
  final bool showLocation;
  final bool showCarrier;
  final bool showAvatar;
  final bool enableDrag;
  
  CallerIdConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.fontSize,
    required this.borderRadius,
    required this.opacity,
    required this.position,
    required this.showLocation,
    required this.showCarrier,
    required this.showAvatar,
    required this.enableDrag,
  });
  
  /// 创建默认配置
  factory CallerIdConfig.defaultConfig() {
    return CallerIdConfig(
      backgroundColor: '#000000',
      textColor: '#FFFFFF',
      fontSize: 16.0,
      borderRadius: 8.0,
      opacity: 0.8,
      position: 'top',
      showLocation: true,
      showCarrier: true,
      showAvatar: true,
      enableDrag: true,
    );
  }
  
  /// 转换为Map
  Map<String, dynamic> toMap() {
    return {
      'backgroundColor': backgroundColor,
      'textColor': textColor,
      'fontSize': fontSize,
      'borderRadius': borderRadius,
      'opacity': opacity,
      'position': position,
      'showLocation': showLocation,
      'showCarrier': showCarrier,
      'showAvatar': showAvatar,
      'enableDrag': enableDrag,
    };
  }
  
  /// 从Map创建
  factory CallerIdConfig.fromMap(Map<String, dynamic> map) {
    return CallerIdConfig(
      backgroundColor: map['backgroundColor'] ?? '#000000',
      textColor: map['textColor'] ?? '#FFFFFF',
      fontSize: map['fontSize'] ?? 16.0,
      borderRadius: map['borderRadius'] ?? 8.0,
      opacity: map['opacity'] ?? 0.8,
      position: map['position'] ?? 'top',
      showLocation: map['showLocation'] ?? true,
      showCarrier: map['showCarrier'] ?? true,
      showAvatar: map['showAvatar'] ?? true,
      enableDrag: map['enableDrag'] ?? true,
    );
  }
  
  /// 创建副本并更新部分属性
  CallerIdConfig copyWith({
    String? backgroundColor,
    String? textColor,
    double? fontSize,
    double? borderRadius,
    double? opacity,
    String? position,
    bool? showLocation,
    bool? showCarrier,
    bool? showAvatar,
    bool? enableDrag,
  }) {
    return CallerIdConfig(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      fontSize: fontSize ?? this.fontSize,
      borderRadius: borderRadius ?? this.borderRadius,
      opacity: opacity ?? this.opacity,
      position: position ?? this.position,
      showLocation: showLocation ?? this.showLocation,
      showCarrier: showCarrier ?? this.showCarrier,
      showAvatar: showAvatar ?? this.showAvatar,
      enableDrag: enableDrag ?? this.enableDrag,
    );
  }
}