// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_cache_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 【核心修改】: 使用 @riverpod 注解
///
/// - `@Riverpod()`: 告诉生成器为这个 Notifier 创建一个 Provider。
/// - `keepAlive`: 类似于 `.autoDispose` 的反向操作。我们在这里设置为 `true`，
///              意味着即使用户滑走了（最后一个监听者被移除），Provider 也不会被销毁。
///              这正是我们“缓存”所需要的行为！广告会一直保留在内存中，直到应用关闭。
///              如果您仍然希望它在不被使用时销毁，可以移除 `keepAlive: true`。

@ProviderFor(AdCache)
const adCacheProvider = AdCacheFamily._();

/// 【核心修改】: 使用 @riverpod 注解
///
/// - `@Riverpod()`: 告诉生成器为这个 Notifier 创建一个 Provider。
/// - `keepAlive`: 类似于 `.autoDispose` 的反向操作。我们在这里设置为 `true`，
///              意味着即使用户滑走了（最后一个监听者被移除），Provider 也不会被销毁。
///              这正是我们“缓存”所需要的行为！广告会一直保留在内存中，直到应用关闭。
///              如果您仍然希望它在不被使用时销毁，可以移除 `keepAlive: true`。
final class AdCacheProvider extends $NotifierProvider<AdCache, AdCacheState> {
  /// 【核心修改】: 使用 @riverpod 注解
  ///
  /// - `@Riverpod()`: 告诉生成器为这个 Notifier 创建一个 Provider。
  /// - `keepAlive`: 类似于 `.autoDispose` 的反向操作。我们在这里设置为 `true`，
  ///              意味着即使用户滑走了（最后一个监听者被移除），Provider 也不会被销毁。
  ///              这正是我们“缓存”所需要的行为！广告会一直保留在内存中，直到应用关闭。
  ///              如果您仍然希望它在不被使用时销毁，可以移除 `keepAlive: true`。
  const AdCacheProvider._({
    required AdCacheFamily super.from,
    required AdInfo super.argument,
  }) : super(
         retry: null,
         name: r'adCacheProvider',
         isAutoDispose: false,
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

String _$adCacheHash() => r'fe67cbb823ef8b44207872927ed92dfa7b272e91';

/// 【核心修改】: 使用 @riverpod 注解
///
/// - `@Riverpod()`: 告诉生成器为这个 Notifier 创建一个 Provider。
/// - `keepAlive`: 类似于 `.autoDispose` 的反向操作。我们在这里设置为 `true`，
///              意味着即使用户滑走了（最后一个监听者被移除），Provider 也不会被销毁。
///              这正是我们“缓存”所需要的行为！广告会一直保留在内存中，直到应用关闭。
///              如果您仍然希望它在不被使用时销毁，可以移除 `keepAlive: true`。

final class AdCacheFamily extends $Family
    with
        $ClassFamilyOverride<
          AdCache,
          AdCacheState,
          AdCacheState,
          AdCacheState,
          AdInfo
        > {
  const AdCacheFamily._()
    : super(
        retry: null,
        name: r'adCacheProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// 【核心修改】: 使用 @riverpod 注解
  ///
  /// - `@Riverpod()`: 告诉生成器为这个 Notifier 创建一个 Provider。
  /// - `keepAlive`: 类似于 `.autoDispose` 的反向操作。我们在这里设置为 `true`，
  ///              意味着即使用户滑走了（最后一个监听者被移除），Provider 也不会被销毁。
  ///              这正是我们“缓存”所需要的行为！广告会一直保留在内存中，直到应用关闭。
  ///              如果您仍然希望它在不被使用时销毁，可以移除 `keepAlive: true`。

  AdCacheProvider call(AdInfo adInfo) =>
      AdCacheProvider._(argument: adInfo, from: this);

  @override
  String toString() => r'adCacheProvider';
}

/// 【核心修改】: 使用 @riverpod 注解
///
/// - `@Riverpod()`: 告诉生成器为这个 Notifier 创建一个 Provider。
/// - `keepAlive`: 类似于 `.autoDispose` 的反向操作。我们在这里设置为 `true`，
///              意味着即使用户滑走了（最后一个监听者被移除），Provider 也不会被销毁。
///              这正是我们“缓存”所需要的行为！广告会一直保留在内存中，直到应用关闭。
///              如果您仍然希望它在不被使用时销毁，可以移除 `keepAlive: true`。

abstract class _$AdCache extends $Notifier<AdCacheState> {
  late final _$args = ref.$arg as AdInfo;
  AdInfo get adInfo => _$args;

  AdCacheState build(AdInfo adInfo);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AdCacheState, AdCacheState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AdCacheState, AdCacheState>,
              AdCacheState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
