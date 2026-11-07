// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comic_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ComicActions)
const comicActionsProvider = ComicActionsFamily._();

final class ComicActionsProvider
    extends $NotifierProvider<ComicActions, List<UserAction>> {
  const ComicActionsProvider._(
      {required ComicActionsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'comicActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$comicActionsHash();

  @override
  String toString() {
    return r'comicActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ComicActions create() => ComicActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ComicActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$comicActionsHash() => r'46170a2219b71dd0d236375c2b5c40134b480eaf';

final class ComicActionsFamily extends $Family
    with
        $ClassFamilyOverride<ComicActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const ComicActionsFamily._()
      : super(
          retry: null,
          name: r'comicActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  ComicActionsProvider call(
    String contentId,
  ) =>
      ComicActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'comicActionsProvider';
}

abstract class _$ComicActions extends $Notifier<List<UserAction>> {
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
