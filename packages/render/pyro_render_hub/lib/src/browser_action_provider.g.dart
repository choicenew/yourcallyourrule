// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'browser_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 浏览器专属的动作提供者，符合统一的 ActionProvider 协议 (Riverpod 3 自动生成 Notifier)

@ProviderFor(BrowserActions)
const browserActionsProvider = BrowserActionsFamily._();

/// 浏览器专属的动作提供者，符合统一的 ActionProvider 协议 (Riverpod 3 自动生成 Notifier)
final class BrowserActionsProvider
    extends $NotifierProvider<BrowserActions, List<UserAction>> {
  /// 浏览器专属的动作提供者，符合统一的 ActionProvider 协议 (Riverpod 3 自动生成 Notifier)
  const BrowserActionsProvider._(
      {required BrowserActionsFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'browserActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$browserActionsHash();

  @override
  String toString() {
    return r'browserActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BrowserActions create() => BrowserActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BrowserActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$browserActionsHash() => r'9a1cd1efe572f7da7bf642c99aaa4afd7e399ddc';

/// 浏览器专属的动作提供者，符合统一的 ActionProvider 协议 (Riverpod 3 自动生成 Notifier)

final class BrowserActionsFamily extends $Family
    with
        $ClassFamilyOverride<BrowserActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const BrowserActionsFamily._()
      : super(
          retry: null,
          name: r'browserActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  /// 浏览器专属的动作提供者，符合统一的 ActionProvider 协议 (Riverpod 3 自动生成 Notifier)

  BrowserActionsProvider call(
    String contentId,
  ) =>
      BrowserActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'browserActionsProvider';
}

/// 浏览器专属的动作提供者，符合统一的 ActionProvider 协议 (Riverpod 3 自动生成 Notifier)

abstract class _$BrowserActions extends $Notifier<List<UserAction>> {
  late final _$args = ref.$arg as String;
  String get contentId => _$args;

  List<UserAction> build(
    String contentId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<List<UserAction>, List<UserAction>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<UserAction>, List<UserAction>>,
        List<UserAction>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
