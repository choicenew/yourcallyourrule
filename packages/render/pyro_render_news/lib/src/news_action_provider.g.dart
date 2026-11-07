// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsActions)
const newsActionsProvider = NewsActionsFamily._();

final class NewsActionsProvider
    extends $NotifierProvider<NewsActions, List<UserAction>> {
  const NewsActionsProvider._(
      {required NewsActionsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'newsActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newsActionsHash();

  @override
  String toString() {
    return r'newsActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NewsActions create() => NewsActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NewsActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$newsActionsHash() => r'1047815add34ed8a1c847ab3affaff80f0a9cb98';

final class NewsActionsFamily extends $Family
    with
        $ClassFamilyOverride<NewsActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const NewsActionsFamily._()
      : super(
          retry: null,
          name: r'newsActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  NewsActionsProvider call(
    String contentId,
  ) =>
      NewsActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'newsActionsProvider';
}

abstract class _$NewsActions extends $Notifier<List<UserAction>> {
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
