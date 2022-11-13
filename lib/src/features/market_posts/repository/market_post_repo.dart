import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_connect/src/features/market_posts/models/market_post.dart';
import 'package:market_connect/src/utilities/constants/string_consts.dart';

class PostRepository {
  const PostRepository({
    required this.fireStorage,
    required this.firestore,
  });
  final FirebaseFirestore firestore;
  final FirebaseStorage fireStorage;

  Future<File?> pickImage() async {
    final imagePicker = ImagePicker();
    final imagePicked = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);
    if (imagePicked != null) {
      log(imagePicked.path);
      return File(imagePicked.path);
    }
    return null;
  }

  Future<void> uploadPost({
    required MarketPost post,
    required File? postImage,
  }) async {
    final fbStorage = fireStorage.ref().child("marketPosts");
    String imageUrl = "";

    if (postImage != null) {
      final imageRef = fbStorage
          .child("${post.authorId}/PI${DateTime.now().toIso8601String()}.jpg");
      //TODO: Buggy if no file is picked
      await imageRef.putFile(File(postImage.path));
      imageUrl = await imageRef.getDownloadURL();
    }

    final postId = firestore
        .collection(FirestoreCollection.marketPosts)
        .doc(post.authorId)
        .collection(FirestoreCollection.individualPost)
        .doc()
        .id;
    final newPost = post.copyWith(imageUrl: imageUrl, postId: postId);
    await firestore
        .collection(FirestoreCollection.marketPosts)
        .doc(post.authorId)
        .collection(FirestoreCollection.individualPost)
        .doc(postId)
        .set(
          newPost.toMap(),
        );
  }

  void likePost({required MarketPost post, required String userId}) async {
    post.likes.contains(userId)
        ? post.likes.remove(userId)
        : post.likes.add(userId);

    await firestore
        .collection(FirestoreCollection.marketPosts)
        .doc(post.authorId)
        .collection(FirestoreCollection.individualPost)
        .doc(post.postId)
        .update({"likes": post.likes});
  }
   void deletePost( MarketPost post) async {
    await firestore
        .collection(FirestoreCollection.marketPosts)
        .doc(post.authorId)
        .collection(FirestoreCollection.individualPost)
        .doc(post.postId)
        .delete();
  }

  Future<List<MarketPost>> getProfilePosts(String userId) async {
    final qryProfilePosts = await firestore
        .collection(FirestoreCollection.marketPosts)
        .doc(userId)
        .collection(FirestoreCollection.individualPost)
        .get();
    final profilePosts = qryProfilePosts.docs;

    if (profilePosts.isEmpty) {
      return [];
    }

    return profilePosts
        .map((qryDocSnap) => MarketPost.fromMap(qryDocSnap.data()))
        .toList();
  }
}

final marketPostRepoProvider = Provider((ref) {
  return PostRepository(
    fireStorage: FirebaseStorage.instance,
    firestore: FirebaseFirestore.instance,
  );
});

