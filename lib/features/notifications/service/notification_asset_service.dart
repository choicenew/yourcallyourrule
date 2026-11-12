import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_asset_service.g.dart';

@Riverpod(keepAlive: true)
NotificationAssetService notificationAssetService(Ref ref) {
  return NotificationAssetService();
}

class NotificationAssetService {
  Future<String?> prepareAsset({required String assetOrUrl}) async {
    try {
      final directory = await getTemporaryDirectory();
      final fileName = '${assetOrUrl.hashCode}.png';
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      if (await file.exists()) {
        return filePath;
      }
      
      if (assetOrUrl.startsWith('http')) {
        final request = await HttpClient().getUrl(Uri.parse(assetOrUrl));
        final response = await request.close();
        if (response.statusCode == 200) {
          final bytes = await response.fold<List<int>>([], (acc, chunk) => acc..addAll(chunk));
          await file.writeAsBytes(bytes);
          return filePath;
        }
      } 
      else if (assetOrUrl.startsWith('assets/')) {
        final byteData = await rootBundle.load(assetOrUrl);
        await file.writeAsBytes(byteData.buffer.asUint8List());
        return filePath;
      }
    } catch (e) {
      debugPrint(">>> [NotificationAssetService] Error preparing asset '$assetOrUrl': $e");
    }
    
    return null;
  }
}
