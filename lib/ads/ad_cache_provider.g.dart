// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 【优化】: 移除 keepAlive: true，允许广告页面离开时自动销毁和清理 Native 贴图与内存

@ProviderFor(AdCache)
final adCacheProvider = AdCacheFamily._();

/// 【优化】: 移除 keepAlive: true，允许广告页面离开时自动销毁和清理 Native 贴图与内存
final class AdCacheProvider extends $NotifierProvider<AdCache, AdCacheState> {
  /// 【优化】: 移除 keepAlive: true，允许广告页面离开时自动销毁和清理 Native 贴图与内存
  AdCacheProvider._({
    required AdCacheFamily super.from,
    required AdInfo super.argument,
  }) : super(
         retry: null,
         name: r'adCacheProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$adCacheHash();

  @override
  String toString() {
    return r'adCacheProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdCache create() => AdCache();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AdCacheState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AdCacheState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AdCacheProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adCacheHash() => r'7bd62bd1ca9bd9327724c92f8bf0efa2aab869b7';

/// 【优化】: 移除 keepAlive: true，允许广告页面离开时自动销毁和清理 Native 贴图与内存

final class AdCacheFamily extends $Family
    with
        $ClassFamilyOverride<
          AdCache,
          AdCacheState,
          AdCacheState,
          AdCacheState,
          AdInfo
        > {
  AdCacheFamily._()
    : super(
        retry: null,
        name: r'adCacheProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 【优化】: 移除 keepAlive: true，允许广告页面离开时自动销毁和清理 Native 贴图与内存

  AdCacheProvider call(AdInfo adInfo) =>
      AdCacheProvider._(argument: adInfo, from: this);

  @override
  String toString() => r'adCacheProvider';
}

/// 【优化】: 移除 keepAlive: true，允许广告页面离开时自动销毁和清理 Native 贴图与内存

abstract class _$AdCache extends $Notifier<AdCacheState> {
  late final _$args = ref.$arg as AdInfo;
  AdInfo get adInfo => _$args;

  AdCacheState build(AdInfo adInfo);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AdCacheState, AdCacheState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdCacheState, AdCacheState>,
              AdCacheState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
