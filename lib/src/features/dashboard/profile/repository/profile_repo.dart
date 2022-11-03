import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/utilities/constants/string_consts.dart';

class ProfileRepository {
  const ProfileRepository({
    required this.firestore,
    required this.fStorage,
  });
  final FirebaseFirestore firestore;
  final FirebaseStorage fStorage;
  Future<MarketUser> getUser(String uid) async {
    final docMap = (await firestore
            .collection(FirestoreCollection.marketUsers)
            .doc(uid)
            .get())
        .data();

    return MarketUser.fromMap(docMap!);
  }

  Future<void> uploadProfileImage(String userId) async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 55);
    if (pickedImage != null) {
      //final imageRef = fStorage.ref().child("profileImages").child("$userId/DP_${DateTime.now().toIso8601String()}");
      final imageRef = fStorage.ref().child("profileImages").child(userId);
      await imageRef.putFile(File(pickedImage.path));
      final uploadLink = await imageRef.getDownloadURL();
      await firestore.collection(FirestoreCollection.marketUsers).doc(userId).update({"photoUrl": uploadLink});
    }
    return;
  }

  void follow(String primaryUid, String secondaryUid) async {
    if (primaryUid == secondaryUid) {
      return;
    }
    final follower = await getUser(primaryUid);

    if (follower.following.contains(secondaryUid)) {
      await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(primaryUid)
          .update({
        'following': FieldValue.arrayRemove([secondaryUid])
      });
      await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(secondaryUid)
          .update({
        'followers': FieldValue.arrayRemove([primaryUid])
      });
    } else {
      await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(secondaryUid)
          .update({
        'followers': FieldValue.arrayUnion([primaryUid])
      });
      await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(primaryUid)
          .update({
        'following': FieldValue.arrayUnion([secondaryUid])
      });
    }
  }

  Future<List<MarketUser>> getAllUsers() async {
    return (await firestore.collection(FirestoreCollection.marketUsers).get())
        .docs
        .map((qUser) {
      final user = qUser.data();
      return MarketUser.fromMap(user);
    }).toList();
  }
}

final profileRepoProvider = Provider((ref) {
  return ProfileRepository(
    firestore: FirebaseFirestore.instance,
    fStorage: FirebaseStorage.instance,
  );
});
