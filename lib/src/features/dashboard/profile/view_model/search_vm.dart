import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/repository/profile_repo.dart';

class SearchNotifier extends StateNotifier<List<MarketUser>> {
  SearchNotifier({required this.profileRepository}) : super([]);

  final ProfileRepository profileRepository;

  Stream<List<MarketUser>> search(String text) async* {
    final users = await profileRepository.getAllUsers();
    [...users];
    state = users
        .where((user) =>
            user.marketName.toLowerCase().contains(text.toLowerCase()) ||
            user.email.toLowerCase().contains(text.toLowerCase()))
        .toList();
    yield state;
  }
}

// final searchVmProvider = StateNotifierProvider<SearchNotifier, List<MarketUser>?>((ref) {
//   return SearchNotifier(profileRepository: ref.watch(profileRepoProvider));
// });

final searchVmProvider =
    StreamProvider.family<List<MarketUser>, String>((ref, text) {
  return SearchNotifier(profileRepository: ref.watch(profileRepoProvider))
      .search(text);
});
