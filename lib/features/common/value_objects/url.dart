// URL值对象
class Url {
  final String value;

  const Url(this.value);
  
  /// 从字符串创建URL值对象，并进行格式验证
  /// 如果URL格式无效，将抛出[FormatException]
  factory Url.fromString(String url) {
    // URL格式验证逻辑
    final urlRegExp = RegExp(
      r'^(https?:\/\/)?'+ // 协议
      r'((([a-z\d]([a-z\d-]*[a-z\d])*)\.)+[a-z]{2,}|'+ // 域名
      r'((\d{1,3}\.){3}\d{1,3}))'+ // IP地址
      r'(\:\d+)?(\/[-a-z\d%_.~+]*)*'+ // 端口和路径
      r'(\?[;&a-z\d%_.~+=-]*)?'+ // 查询字符串
      r'(\#[-a-z\d_]*)?$', // 锚点
      caseSensitive: false
    );
    
    if (!urlRegExp.hasMatch(url)) {
      throw FormatException('无效的URL格式: $url');
    }
    
    return Url(url);
  }

  @override
  String toString() => value;
}