// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(voteCountStream)
final voteCountStreamProvider = VoteCountStreamProvider._();

final class VoteCountStreamProvider
    extends $FunctionalProvider<AsyncValue<int>, int, Stream<int>>
    with $FutureModifier<int>, $StreamProvider<int> {
  VoteCountStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voteCountStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voteCountStreamHash();

  @$internal
  @override
  $StreamProviderElement<int> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<int> create(Ref ref) {
    return voteCountStream(ref);
  }
}

String _$voteCountStreamHash() => r'058832ff9a05c5c3d712da4bbb8b6150f286983e';
