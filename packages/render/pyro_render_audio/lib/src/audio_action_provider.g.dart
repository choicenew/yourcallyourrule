// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_action_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AudioActions)
const audioActionsProvider = AudioActionsFamily._();

final class AudioActionsProvider
    extends $NotifierProvider<AudioActions, List<UserAction>> {
  const AudioActionsProvider._(
      {required AudioActionsFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'audioActionsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$audioActionsHash();

  @override
  String toString() {
    return r'audioActionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AudioActions create() => AudioActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserAction> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserAction>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is AudioActionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$audioActionsHash() => r'33d026e14e1ddae5c76c8fb94365484387be6f0f';

final class AudioActionsFamily extends $Family
    with
        $ClassFamilyOverride<AudioActions, List<UserAction>, List<UserAction>,
            List<UserAction>, String> {
  const AudioActionsFamily._()
      : super(
          retry: null,
          name: r'audioActionsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: false,
        );

  AudioActionsProvider call(
    String contentId,
  ) =>
      AudioActionsProvider._(argument: contentId, from: this);

  @override
  String toString() => r'audioActionsProvider';
}

abstract class _$AudioActions extends $Notifier<List<UserAction>> {
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
