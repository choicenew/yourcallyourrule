/// 安全地解析 bool 值，支持 bool、num (1/0)、String ('true'/'false'/'1'/'0') 等类型
bool parseBool(dynamic value, {bool defaultValue = true}) {
  if (value is bool) return value;
  if (value is num) return value == 1;
  if (value is String) {
    final lower = value.toLowerCase().trim();
    if (lower == 'true' || lower == '1') return true;
    if (lower == 'false' || lower == '0') return false;
  }
  return defaultValue;
}
