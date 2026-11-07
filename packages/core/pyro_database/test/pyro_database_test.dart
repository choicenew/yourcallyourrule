import 'package:flutter_test/flutter_test.dart';
import 'package:pyro_database/pyro_database.dart';

void main() {
  group('PyroDatabase 大一统泛化媒体离线数据库微包测试', () {
    test('音乐/图书/漫画/视频多类型 IsarMediaObject CRUD 检索测试', () async {
      final mediaDs = IsarMediaDatasource();

      // 1. 漫画媒体项
      final manga = const IsarMediaObject(
        id: 'manga_one_piece',
        title: '航海王',
        type: 'manga',
        sourceId: 'copy_manga',
        contentUrl: 'https://mangacopy.com/one_piece',
        creators: {'author': '尾田荣一郎'},
        totalChapters: 1100,
        tags: ['热血', '冒险'],
      );

      // 2. 音乐媒体项
      final music = const IsarMediaObject(
        id: 'music_nocturne',
        title: '夜曲',
        type: 'music',
        sourceId: 'net_music',
        contentUrl: 'https://music.example.com/nocturne.mp3',
        creators: {'singer': '周杰伦'},
        album: '十一月的萧邦',
        durationMs: 220000,
        tags: ['流行', '经典'],
      );

      // 3. 视频/电影媒体项
      final video = const IsarMediaObject(
        id: 'video_interstellar',
        title: '星际穿越',
        type: 'video',
        sourceId: 'movie_hub',
        contentUrl: 'https://video.example.com/interstellar.mp4',
        creators: {'director': '克里斯托弗·诺兰'},
        resolution: '4K',
        tags: ['科幻', '硬核'],
      );

      await mediaDs.saveMediaList([manga, music, video]);

      // 验证按类型精准筛选
      final musicList = await mediaDs.getMediaByType('music');
      expect(musicList.length, equals(1));
      expect(musicList.first.title, equals('夜曲'));
      expect(musicList.first.album, equals('十一月的萧邦'));

      // 验证跨多模态模糊搜索
      final searchResult = await mediaDs.searchMedia('周杰伦');
      expect(searchResult.length, equals(1));
      expect(searchResult.first.title, equals('夜曲'));

      final searchDirector = await mediaDs.searchMedia('诺兰');
      expect(searchDirector.length, equals(1));
      expect(searchDirector.first.title, equals('星际穿越'));
    });
  });
}
