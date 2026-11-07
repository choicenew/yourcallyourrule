/// 迁移自 pyro_app 的图书离线存储本地 Scheme 对象模型
class IsarBookObject {
  final String id;
  final String title;
  final String coverUrl;
  final String? author;
  final String? description;
  final int totalChapters;
  final int lastReadChapterIndex;
  final String lastReadTime;

  const IsarBookObject({
    required this.id,
    required this.title,
    required this.coverUrl,
    this.author,
    this.description,
    this.totalChapters = 0,
    this.lastReadChapterIndex = 0,
    required this.lastReadTime,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'coverUrl': coverUrl,
        'author': author,
        'description': description,
        'totalChapters': totalChapters,
        'lastReadChapterIndex': lastReadChapterIndex,
        'lastReadTime': lastReadTime,
      };

  factory IsarBookObject.fromMap(Map<String, dynamic> map) {
    return IsarBookObject(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      coverUrl: map['coverUrl']?.toString() ?? '',
      author: map['author']?.toString(),
      description: map['description']?.toString(),
      totalChapters: (map['totalChapters'] as num?)?.toInt() ?? 0,
      lastReadChapterIndex: (map['lastReadChapterIndex'] as num?)?.toInt() ?? 0,
      lastReadTime: map['lastReadTime']?.toString() ?? DateTime.now().toIso8601String(),
    );
  }
}
