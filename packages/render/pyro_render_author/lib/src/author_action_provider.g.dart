// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthorActions)
const authorActionsProvider = AuthorActionsFamily._();

final class AuthorActionsProvider
    extends $NotifierProvider<AuthorActions, List<UserAction>> {
  const AuthorActionsProvider._(
      {required AuthorActionsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'authorActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authorActionsHash();

  @override
  String toString() {
    return r'authorActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AuthorActions create() => AuthorActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AuthorActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$authorActionsHash() => r'5c7d999405c679bfe491b17ab10091f68d12cd33';

final class AuthorActionsFamily extends $Family
    with
        $ClassFamilyOverride<AuthorActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const AuthorActionsFamily._()
      : super(
          retry: null,
          name: r'authorActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  AuthorActionsProvider call(
    String contentId,
  ) =>
      AuthorActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'authorActionsProvider';
}

abstract class _$AuthorActions extends $Notifier<List<UserAction>> {
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
