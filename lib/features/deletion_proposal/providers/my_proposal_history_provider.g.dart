// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_proposal_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(myProposalHistory)
const myProposalHistoryProvider = MyProposalHistoryProvider._();

final class MyProposalHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MyProposalHistoryItem>>,
          List<MyProposalHistoryItem>,
          FutureOr<List<MyProposalHistoryItem>>
        >
    with
        $FutureModifier<List<MyProposalHistoryItem>>,
        $FutureProvider<List<MyProposalHistoryItem>> {
  const MyProposalHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProposalHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProposalHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<MyProposalHistoryItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MyProposalHistoryItem>> create(Ref ref) {
    return myProposalHistory(ref);
  }
}

String _$myProposalHistoryHash() => r'74b03f61e4629dd66f754671fa059973cd165453';
