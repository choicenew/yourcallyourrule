// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 一个异步 Provider，负责请求权限并获取设备上所有 SIM 卡的信息。
/// 它会自动处理加载、错误和成功状态，并缓存结果。
/// Riverpod 会自动处理 keepAlive，确保信息只被获取一次。

@ProviderFor(simCards)
final simCardsProvider = SimCardsProvider._();

/// 一个异步 Provider，负责请求权限并获取设备上所有 SIM 卡的信息。
/// 它会自动处理加载、错误和成功状态，并缓存结果。
/// Riverpod 会自动处理 keepAlive，确保信息只被获取一次。

final class SimCardsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SimCardEntity>>,
          List<SimCardEntity>,
          FutureOr<List<SimCardEntity>>
        >
    with
        $FutureModifier<List<SimCardEntity>>,
        $FutureProvider<List<SimCardEntity>> {
  /// 一个异步 Provider，负责请求权限并获取设备上所有 SIM 卡的信息。
  /// 它会自动处理加载、错误和成功状态，并缓存结果。
  /// Riverpod 会自动处理 keepAlive，确保信息只被获取一次。
  SimCardsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'simCardsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$simCardsHash();

  @$internal
  @override
  $FutureProviderElement<List<SimCardEntity>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SimCardEntity>> create(Ref ref) {
    return simCards(ref);
  }
}

String _$simCardsHash() => r'44b9f75d874385eb2102a827971280f05f4d43fd';
