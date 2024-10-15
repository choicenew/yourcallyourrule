class Label {
  String phoneNumber; // 电话
  String? name; // 电话名称
  String? avatar; // 标签头像
  String label; // 标签文本内容

  Label({
    required this.phoneNumber,
    this.name,
    this.avatar,
    required this.label,
  });

  factory Label.fromJson(Map<String, dynamic> json) {
    return Label(
      phoneNumber: json['phoneNumber'],
      name: json['name'],
      avatar: json['avatar'],
      label: json['label'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'phoneNumber': phoneNumber,
      'name': name,
      'avatar': avatar,
      'label': label,
    };
    return data;
  }
}
