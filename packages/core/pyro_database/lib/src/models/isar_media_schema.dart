import 'package:pyro_media_models/pyro_media_models.dart';

/// 1:1 对齐 Pyro 架构 MediaEntity 的大一统泛化媒体离线 Object 模型
class IsarMediaObject {
  final String id;
  final String title;
  final String? coverUrl;
  final String? thumbUrl;
  final String? description;
  final String type; // MediaType 的字符串映射: book, novel, manga, music, audio, video, academic, wallpaper, album
  final String sourceId;
  final String contentUrl;
  final String? localPath;

  // 创作者矩阵
  final Map<String, String> creators;

  // 集合特质
  final bool isCollection;
  final List<String> itemIds;
  final String? parentId;
  final double index;

  // 多模态特征池
  final String? album;
  final int? trackNumber;
  final int? discNumber;
  final String? lyrics;
  final int? durationMs;
  final String? resolution;
  final int? bitrate;
  final int? wordCount;
  final int? pageCount;
  final int? totalChapters;
  final String? doi;
  final String? journal;
  final String? abstractText;

  // 消费状态与标记
  final String status;
  final double score;
  final List<String> tags;
  final String? category;
  final String? publisher;
  final String? publishDate;

  // 消费进度
  final double progress;
  final String? lastPositionId;
  final String? lastPositionTitle;

  const IsarMediaObject({
    required this.id,
    required this.title,
    this.coverUrl,
    this.thumbUrl,
    this.description,
    required this.type,
    required this.sourceId,
    required this.contentUrl,
    this.localPath,
    this.creators = const {},
    this.isCollection = false,
    this.itemIds = const [],
    this.parentId,
    this.index = 0.0,
    this.album,
    this.trackNumber,
    this.discNumber,
    this.lyrics,
    this.durationMs,
    this.resolution,
    this.bitrate,
    this.wordCount,
    this.pageCount,
    this.totalChapters,
    this.doi,
    this.journal,
    this.abstractText,
    this.status = 'unread',
    this.score = 0.0,
    this.tags = const [],
    this.category,
    this.publisher,
    this.publishDate,
    this.progress = 0.0,
    this.lastPositionId,
    this.lastPositionTitle,
  });

  /// 将领域 Entity 转为离线 IsarMediaObject
  factory IsarMediaObject.fromEntity(MediaEntity entity) {
    return IsarMediaObject(
      id: entity.id,
      title: entity.title,
      coverUrl: entity.coverUrl,
      thumbUrl: entity.thumbUrl,
      description: entity.description,
      type: entity.type.name,
      sourceId: entity.sourceId,
      contentUrl: entity.contentUrl,
      localPath: entity.localPath,
      creators: entity.creators,
      isCollection: entity.isCollection,
      itemIds: entity.itemIds,
      parentId: entity.parentId,
      index: entity.index,
      album: entity.album,
      trackNumber: entity.trackNumber,
      discNumber: entity.discNumber,
      lyrics: entity.lyrics,
      durationMs: entity.duration?.inMilliseconds,
      resolution: entity.resolution,
      bitrate: entity.bitrate,
      wordCount: entity.wordCount,
      pageCount: entity.pageCount,
      totalChapters: entity.totalChapters,
      doi: entity.doi,
      journal: entity.journal,
      abstractText: entity.abstract,
      status: entity.status.name,
      score: entity.score,
      tags: entity.tags,
      category: entity.category,
      publisher: entity.publisher,
      publishDate: entity.publishDate,
      progress: entity.progress,
      lastPositionId: entity.lastPositionId,
      lastPositionTitle: entity.lastPositionTitle,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'coverUrl': coverUrl,
        'thumbUrl': thumbUrl,
        'description': description,
        'type': type,
        'sourceId': sourceId,
        'contentUrl': contentUrl,
        'localPath': localPath,
        'creators': creators,
        'isCollection': isCollection,
        'itemIds': itemIds,
        'parentId': parentId,
        'index': index,
        'album': album,
        'trackNumber': trackNumber,
        'discNumber': discNumber,
        'lyrics': lyrics,
        'durationMs': durationMs,
        'resolution': resolution,
        'bitrate': bitrate,
        'wordCount': wordCount,
        'pageCount': pageCount,
        'totalChapters': totalChapters,
        'doi': doi,
        'journal': journal,
        'abstractText': abstractText,
        'status': status,
        'score': score,
        'tags': tags,
        'category': category,
        'publisher': publisher,
        'publishDate': publishDate,
        'progress': progress,
        'lastPositionId': lastPositionId,
        'lastPositionTitle': lastPositionTitle,
      };
}
