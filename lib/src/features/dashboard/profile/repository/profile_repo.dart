import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/utilities/constants/string_consts.dart';

class ProfileRepository {
  const ProfileRepository({required this.firestore});
  final FirebaseFirestore firestore;
  Future<MarketUser> getUser(String uid) async {
    final docMap = (await firestore
            .collection(FirestoreCollection.marketUsers)
            .doc(uid)
            .get())
        .data();

    return MarketUser.fromMap(docMap!);
  }

  // bool isFollowing (String secondaryAccount) async {
  //   final primaryAccount = 
  // }

  void follow(String primaryUid, String secondaryUid) async {
    // primaryUid is the loggedIn User (that follows)
    if (primaryUid == secondaryUid ) {
      return ;
    }
    final follower = await getUser(primaryUid);
    //final secAccount = await getUser(secondaryUid);

    if (follower.following.contains(secondaryUid)) {
      // follower.following.remove(secAccount);
      // secAccount.followers.remove(follower);
      await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(primaryUid)
          .update({
        'following': FieldValue.arrayRemove([secondaryUid])
        //'following': FieldValue.arrayRemove([secAccount.toMap() as dynamic])
      });
      await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(secondaryUid)
          .update({
        'followers': FieldValue.arrayRemove([primaryUid])
        // 'followers': FieldValue.arrayRemove([follower.toMap() as dynamic])
      });
    } else {
      // follower.following.add(secAccount);
      // secAccount.followers.add(follower);
      await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(secondaryUid)
          .update({
        'followers': FieldValue.arrayUnion([primaryUid])
        // 'followers': FieldValue.arrayUnion([follower.toMap() as dynamic])
      });
       await firestore
          .collection(FirestoreCollection.marketUsers)
          .doc(primaryUid)
          .update({
            'following': FieldValue.arrayUnion([secondaryUid])
        //'following': FieldValue.arrayUnion([secAccount.toMap() as dynamic])
      });
    }
    // final newFollowing = follower.following;

    // final newFollower = secAccount.followers;

    // await firestore
    //     .collection(FirestoreCollection.marketUsers)
    //     .doc(primaryUid)
    //     .update({'following': newFollowing.map((user) => user.toMap()).toList()});
    // await firestore
    //     .collection(FirestoreCollection.marketUsers)
    //     .doc(secondaryUid)
    //     .update({'followers': newFollower.map((user) => user.toMap()).toList()});
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
  return ProfileRepository(firestore: FirebaseFirestore.instance);
});
