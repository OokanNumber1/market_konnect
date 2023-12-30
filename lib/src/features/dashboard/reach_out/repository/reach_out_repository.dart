import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/dashboard/reach_out/model/reach_out.dart';
import 'package:market_connect/src/utilities/constants/string_consts.dart';

class ReachOutRepository {
  const ReachOutRepository({required this.firestore});
  final FirebaseFirestore firestore;

  void sendMessage(ReachOut reachOut) async {
    final doc =
        firestore.collection(FirestoreCollection.reachOut).doc(getDate());

    await doc.set({"nameId": getDate()});

    await doc.collection(FirestoreCollection.dms).add(reachOut.toMap());
  }

  Stream<List<ReachOut>> getMessages({
    required String primaryUserId,
    required String secondaryUserId,
  }) {
    final reachOuts = firestore
        .collection(FirestoreCollection.reachOut)
        .doc(getDate())
        .collection(FirestoreCollection.dms)
        .orderBy("dateTime", descending: true)
        .snapshots();

    return reachOuts.map((querySnapShot) {
      final docs = querySnapShot.docs;
      return docs.map((queryDocSnap) {
        return ReachOut.fromMap(queryDocSnap);
      }).toList();
    });
  }

  Stream<List<String>> getReachOutOverview(String primaryUserId) async* {
    List<String> overviews = [];

    final response =
        await firestore.collection(FirestoreCollection.reachOut).get();
    final dates = response.docs.map((doc) => doc.id).toList();
    print("dates============>$dates");
    for (String date in dates) {
      final queryResponse =await firestore
          .collection(FirestoreCollection.reachOut)
          .doc(date)
          .collection(FirestoreCollection.dms)
          .where("senderId", isEqualTo: primaryUserId)
          .get();
for (var queDoc in queryResponse.docs) {
  final receiverId = queDoc.data()['receiverId'] as String;
         print("receiver=++======$receiverId");
          overviews.add(receiverId);
}
        //   queryResponse.docs.map((doc) {
        //  final receiverId = doc.data()['receiverId'] as String;
        //  print("receiver=++======$receiverId");
        //   overviews.add(receiverId);
        // });
    }
    print("overviews=========>$overviews");
    yield overviews;
  }

  String getDate() {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }
}

final reachOutRepoProvider = Provider<ReachOutRepository>((ref) {
  return ReachOutRepository(firestore: FirebaseFirestore.instance);
});
