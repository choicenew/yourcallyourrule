// 导入核心包
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// 导入 Riverpod
import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 指令
part 'notification_asset_service.g.dart';

/// 通知资源服务 Provider
///
/// 这是一个简单的服务型 Provider，提供一个 NotificationAssetService 的单例。
@Riverpod(keepAlive: true)
NotificationAssetService notificationAssetService(Ref ref) {
  return NotificationAssetService();
}

/// 通知资源服务
///
/// 职责：将一个通用的资源标识符（如网络URL或本地Asset路径）
/// 转换为一个可供 `flutter_local_notifications` 插件使用的本地文件路径。
class NotificationAssetService {

  /// 准备一个可用于通知 `largeIcon` 的文件路径。
  ///
  /// 它会处理网络URL和本地Asset路径：
  /// - 如果是网络URL，会下载图片到临时目录。
  /// - 如果是本地Asset，会从包中复制到临时目录。
  /// - 为了性能，它会进行简单的缓存检查，如果文件已存在则直接返回路径。
  ///
  /// [assetOrUrl] 资源的路径 (例如 'assets/images/a.png') 或 URL (例如 'http://.../a.png')。
  /// 返回一个指向本地临时文件的绝对路径，如果失败则返回 null。
  Future<String?> prepareAsset({required String assetOrUrl}) async {
    try {
      final directory = await getTemporaryDirectory();
      // 使用 assetOrUrl 的哈希值作为文件名，以避免非法字符并实现简单的缓存键
      final fileName = '${assetOrUrl.hashCode}.png'; // 假设为png
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      // 如果文件已在缓存中，则直接返回路径
      if (await file.exists()) {
        debugPrint(">>> [NotificationAssetService] Found asset in cache: $filePath");
        return filePath;
      }
      
      // 处理网络图片
      if (assetOrUrl.startsWith('http')) {
        debugPrint(">>> [NotificationAssetService] Downloading network asset: $assetOrUrl");
        final response = await http.get(Uri.parse(assetOrUrl));
        if (response.statusCode == 200) {
          await file.writeAsBytes(response.bodyBytes);
          return filePath;
        }
      } 
      // 处理本地 Assets
      else if (assetOrUrl.startsWith('assets/')) {
        debugPrint(">>> [NotificationAssetService] Copying local asset: $assetOrUrl");
        final byteData = await rootBundle.load(assetOrUrl);
        await file.writeAsBytes(byteData.buffer.asUint8List());
        return filePath;
      }
    } catch (e) {
      debugPrint(">>> [NotificationAssetService] Error preparing asset '$assetOrUrl': $e");
    }
    
    // 如果所有尝试都失败，返回 null
    return null;
  }
}