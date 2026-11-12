import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vote_count_provider.g.dart';

@riverpod
Stream<int> voteCountStream(Ref ref) {
  return Stream.value(0);
}
