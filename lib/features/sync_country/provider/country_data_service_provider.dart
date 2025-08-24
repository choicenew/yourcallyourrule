import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yourcallyourrule/core/provider/datasource/remote_number_data_source_provider.dart';
import 'package:yourcallyourrule/core/provider/providers/api_service_provider.dart';
import 'package:yourcallyourrule/features/sync_country/services/country_data_service.dart';

final countryDataServiceProvider = Provider<CountryDataService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final remoteNumberDataSource = ref.watch(remoteNumberDataSourceProvider);
  return CountryDataService(
    apiService: apiService,
    remoteNumberDataSource: remoteNumberDataSource,
  );
});