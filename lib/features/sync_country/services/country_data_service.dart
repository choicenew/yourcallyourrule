import 'package:yourcallyourrule/data/database/sync/api_service.dart';
import 'package:yourcallyourrule/data/datasources/remote/remote_number_datasource.dart';

/// 这个服务负责一次性下载特定国家的完整数据集。
class CountryDataService {
  final ApiService _apiService;
  final RemoteNumberDataSource _dataSource;

  CountryDataService({
    required ApiService apiService,
    required RemoteNumberDataSource remoteNumberDataSource,
  }) : _apiService = apiService,
       _dataSource = remoteNumberDataSource;

  /// 下载指定国家代码的所有号码并将其保存到本地数据库。
  /// 返回下载的数据条数
  Future<int> downloadCountryData(String countryDialCode) async {
    try {
      // 1. 从新的API端点获取该国家的完整号码列表
      final numbers = await _apiService.getInitialDataForCountry(countryDialCode);

      if (numbers.isNotEmpty) {
        // 2. 使用特殊通道批量保存这些数据，不记录到pending_operations
        await _dataSource.bulkInsertFromServer(numbers);
      }

      return numbers.length;
    } catch (e) {
      // 处理或重新抛出错误
      print('Failed to download data for country $countryDialCode: $e');
      throw Exception('下载国家数据失败: $e');
    }
  }
  
  /// 移除特定国家的数据
  /// 返回删除的数据条数
  Future<int> removeCountryData(String countryDialCode) async {
    try {
      // 删除以该国家代码开头的所有号码
      final deletedCount = await _dataSource.deleteNumbersByCountryCode(countryDialCode);
      return deletedCount;
    } catch (e) {
      print('Failed to remove data for country $countryDialCode: $e');
      throw Exception('移除国家数据失败: $e');
    }
  }
  }