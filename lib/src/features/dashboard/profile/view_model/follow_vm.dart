import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/repository/profile_repo.dart';

class FollowNotifier extends StateNotifier<MarketUser> {
  FollowNotifier({required this.profileRepository}) : super(MarketUser.empty());

  final ProfileRepository profileRepository;

  void getUser(String uid) async {
    state = await profileRepository.getUser(uid);
  }
}

final followVmProvider = FutureProvider.family<MarketUser, String>((ref, uid) {
  return ref.watch(profileRepoProvider).getUser(uid);
});
