import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/dashboard/profile/repository/profile_repo.dart';

class ProfileNotifier extends StateNotifier<MarketUser> {
  ProfileNotifier({
    required this.profileRepository,
    required this.authRepository,
  }) : super(MarketUser.empty());

  final ProfileRepository profileRepository;
  final AuthRepository authRepository;
  Future<MarketUser> getUser(String uid) async {
    final user = await profileRepository.getUser(uid);
    state = user;
    return user;
  }

  void follow(String primaryUid, String secondaryUid) async {
    profileRepository.follow(primaryUid, secondaryUid);
  }

  Future<MarketUser> getProfile(String uid) async {
    return await profileRepository.getUser(uid);
  }

 Future <void> uploadProfileImage(String userId) async {
   await profileRepository.uploadProfileImage(userId);
  }
}

final profileVmProvider =
    StateNotifierProvider<ProfileNotifier, MarketUser>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return ProfileNotifier(
      profileRepository: ref.watch(profileRepoProvider),
      authRepository: authRepo);
});
