// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'novel_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NovelActions)
const novelActionsProvider = NovelActionsFamily._();

final class NovelActionsProvider
    extends $NotifierProvider<NovelActions, List<UserAction>> {
  const NovelActionsProvider._(
      {required NovelActionsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'novelActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$novelActionsHash();

  @override
  String toString() {
    return r'novelActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NovelActions create() => NovelActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NovelActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$novelActionsHash() => r'dfbdc743e61d3bde61c4a6ba69eaddd6dfc1657e';

final class NovelActionsFamily extends $Family
    with
        $ClassFamilyOverride<NovelActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const NovelActionsFamily._()
      : super(
          retry: null,
          name: r'novelActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  NovelActionsProvider call(
    String contentId,
  ) =>
      NovelActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'novelActionsProvider';
}

abstract class _$NovelActions extends $Notifier<List<UserAction>> {
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
