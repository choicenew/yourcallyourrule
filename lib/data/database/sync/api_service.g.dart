// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ApiService Provider (基于 pyro_cloudflare 微包中的 CloudflareApiService 实例)

@ProviderFor(apiService)
final apiServiceProvider = ApiServiceProvider._();

/// ApiService Provider (基于 pyro_cloudflare 微包中的 CloudflareApiService 实例)

final class ApiServiceProvider
    extends $FunctionalProvider<ApiService, ApiService, ApiService>
    with $Provider<ApiService> {
  /// ApiService Provider (基于 pyro_cloudflare 微包中的 CloudflareApiService 实例)
  ApiServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiServiceHash();

  @$internal
  @override
  $ProviderElement<ApiService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ApiService create(Ref ref) {
    return apiService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ApiService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ApiService>(value),
    );
  }
}

String _$apiServiceHash() => r'ed7ff6ff3b36bbe4c46e658c61854138d19b6f20';
