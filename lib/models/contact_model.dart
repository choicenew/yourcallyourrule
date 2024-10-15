
class Contact {
  String name;
  List<String> phoneNumbers; // 修改为列表
  String? email;
  String? label;
  String? avatarPath; // 新增属性
  String? website; // 新增属性，改为可选项
  String? group; // Add the new property
  String? url; // Add the URL property

  Contact({
    required this.name,
    required this.phoneNumbers,
    this.email,
    this.label,
    this.avatarPath,
    this.website,
    this.group, // Initialize the new property
    this.url, // Initialize the new property
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json['name'],
        phoneNumbers: json['phone_number'] != null
            ? List<String>.from(json['phone_number'])
            : [],
        email: json['email'],
        label: json['label'],
        avatarPath: json['avatarPath'],
        website: json['website'],
        group: json['group'], // Add this line
        url: json['url'], // Add this line
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone_numbers': phoneNumbers,
        'email': email,
        'label': label,
        'avatarPath': avatarPath,
        'website': website,
        'group': group, // Add this line
        'url': url, // Add this line
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact &&
        other.name == name &&
        other.phoneNumbers == phoneNumbers &&
        other.email == email &&
        other.label == label &&
        other.avatarPath == avatarPath &&
        other.website == website &&
        other.group == group && // Include the new property
        other.url == url; // Include the new property
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phoneNumbers.hashCode ^
        email.hashCode ^
        label.hashCode ^
        avatarPath.hashCode ^
        website.hashCode ^
        group.hashCode ^ // Include the new property
        url.hashCode; // Include the new property
  }
}
// 其他与之配合的类和函数 ...

