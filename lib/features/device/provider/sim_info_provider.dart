import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sim_reader/sim_reader.dart';
import 'package:permission_handler/permission_handler.dart';

part 'sim_info_provider.g.dart';

/// 一个异步 Provider，负责请求权限并获取设备上所有 SIM 卡的信息。
/// 它会自动处理加载、错误和成功状态，并缓存结果。
/// Riverpod 会自动处理 keepAlive，确保信息只被获取一次。
@Riverpod(keepAlive: true)
Future<List<SimInfo>> simCards(Ref ref) async {
  // 1. 在 Android 平台处理权限请求。iOS平台不需要显式权限。
  if (Platform.isAndroid) {
    final status = await Permission.phone.request();
    if (!status.isGranted) {
      // 如果用户拒绝了权限，抛出一个清晰的错误，UI层可以捕获并显示。
      throw Exception('Phone permission is required to read SIM information.');
    }
  }
  
  // 2. 检查设备上是否有SIM卡。
  final hasSim = await SimReader.hasSimCard();
  if (!hasSim) {
    // 如果没有SIM卡，返回一个空列表是合理的，而不是抛出错误。
    return [];
  }
  
  // 3. 调用插件获取所有SIM卡信息。
  try {
    final allSimCards = await SimReader.getAllSimInfo();
    return allSimCards;
  } on SimReaderException catch (e) {
    // 捕获插件的特定异常，并将其转换为一个更通用的异常信息。
    throw Exception('Failed to read SIM info: ${e.message}');
  } catch (e) {
    // 捕获其他任何未知异常。
    throw Exception('An unexpected error occurred while reading SIM info.');
  }
}