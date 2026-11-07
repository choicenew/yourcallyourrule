// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 学术文献动作提供者 (Riverpod 3 自动生成 Notifier)

@ProviderFor(PaperActions)
const paperActionsProvider = PaperActionsFamily._();

/// 学术文献动作提供者 (Riverpod 3 自动生成 Notifier)
final class PaperActionsProvider
    extends $NotifierProvider<PaperActions, List<UserAction>> {
  /// 学术文献动作提供者 (Riverpod 3 自动生成 Notifier)
  const PaperActionsProvider._(
      {required PaperActionsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'paperActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$paperActionsHash();

  @override
  String toString() {
    return r'paperActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PaperActions create() => PaperActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PaperActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$paperActionsHash() => r'5e05cb8b2b2e2631ca87ba13a7bdffdb52ce9a74';

/// 学术文献动作提供者 (Riverpod 3 自动生成 Notifier)

final class PaperActionsFamily extends $Family
    with
        $ClassFamilyOverride<PaperActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const PaperActionsFamily._()
      : super(
          retry: null,
          name: r'paperActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  /// 学术文献动作提供者 (Riverpod 3 自动生成 Notifier)

  PaperActionsProvider call(
    String contentId,
  ) =>
      PaperActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'paperActionsProvider';
}

/// 学术文献动作提供者 (Riverpod 3 自动生成 Notifier)

abstract class _$PaperActions extends $Notifier<List<UserAction>> {
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
