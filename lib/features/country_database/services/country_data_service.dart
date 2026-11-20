import 'package:material_ui/material_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yourcallyourrule/core/coordinator/app_hub_exchange_connector.dart';
import 'package:yourcallyourrule/features/remote_filter/data/datasources/remote_number_datasource.dart';

part 'country_data_service.g.dart';

/// CountryDataService 的 @Riverpod Provider
@Riverpod(keepAlive: true)
CountryDataService countryDataService(Ref ref) {
  final centralConnector = ref.watch(appHubExchangeConnectorProvider).centralDatabase;
  final remoteNumberDataSource = ref.watch(remoteNumberDataSourceProvider);
  return CountryDataService(
    centralConnector: centralConnector,
    remoteNumberDataSource: remoteNumberDataSource,
  );
}

/// 这个服务负责一次性下载特定国家的完整数据集。
class CountryDataService {
  final CentralDatabaseExchangeConnector _centralConnector;
  final RemoteNumberDataSource _dataSource;

  CountryDataService({
    required CentralDatabaseExchangeConnector centralConnector,
    required RemoteNumberDataSource remoteNumberDataSource,
  }) : _centralConnector = centralConnector,
       _dataSource = remoteNumberDataSource;

  /// 下载指定国家代码的所有号码并将其保存到本地数据库。
  /// 返回下载的数据条数
  Future<int> downloadCountryData(String countryIsoCode) async {
    try {
      final downloadedCount = await _centralConnector.syncCentralCountryRules(
        countryIsoCode: countryIsoCode,
        dataSource: _dataSource,
      );
      return downloadedCount;
    } catch (e) {
      // 处理或重新抛出错误
      debugPrint('Failed to download data for country $countryIsoCode: $e');
      throw Exception('下载国家数据失败: $e');
    }
  }
  
  /// 移除特定国家的数据
  /// 返回删除的数据条数
  Future<int> removeCountryData(String countryIsoCode) async {
    try {
      // 删除以该国家代码开头的所有号码
      final deletedCount = await _dataSource.deleteNumbersByCountry(countryIsoCode);
      return deletedCount;
    } catch (e) {
      debugPrint('Failed to remove data for country $countryIsoCode: $e');
      throw Exception('移除国家数据失败: $e');
    }
  }
  }