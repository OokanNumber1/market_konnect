import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/repository/profile_repo.dart';
import 'package:market_connect/src/features/market_posts/models/market_post.dart';
import 'package:market_connect/src/features/market_posts/repository/market_post_repo.dart';

class MarketPostNotifier extends StateNotifier<AsyncValue<void>> {
  MarketPostNotifier({required this.profileRepo, required this.postRepo})
      : super(const AsyncData(null));
  final ProfileRepository profileRepo;
  final PostRepository postRepo;

  void uploadPost(
      {required String userId,
      required MarketPost post,
      required File? postImage}) async {
    postRepo.uploadPost(post: post, postImage: postImage);
  }

  Future<File?> pickImage() async {
    return await postRepo.pickImage();
  }

  Future<MarketUser> getAuthor(String uid) async {
    return await profileRepo.getUser(uid);
  }

  Future<List<MarketPost>> getProfilePosts(String userId) async =>
      await postRepo.getProfilePosts(userId);

  void likePost(MarketPost post, String userId) =>
      postRepo.likePost(post: post, userId: userId);

      void deletePost(MarketPost post)=> postRepo.deletePost(post);
}

final marketPostVmProvider =
    StateNotifierProvider<MarketPostNotifier, AsyncValue<void>>((ref) {
  return MarketPostNotifier(
    profileRepo: ref.watch(profileRepoProvider),
    postRepo: ref.watch(marketPostRepoProvider),
  );
});
final profilePostsVmProvider =
    FutureProvider.family<List<MarketPost>, String>((ref, userId) async {
  return ref.watch(marketPostVmProvider.notifier).getProfilePosts(userId);
});
