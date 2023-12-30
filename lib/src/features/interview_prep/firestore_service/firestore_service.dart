import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/interview_prep/model/prep_detail.dart';

class FirestoreService {
  final firestoreInstance = FirebaseFirestore.instance;

  void addFormInAutoDoc(Map<String, dynamic> dto) async {
    await firestoreInstance.collection("prep").doc().set(dto);
  }

  void addFormWithID(Map<String, dynamic> dto) async {
    await firestoreInstance.collection("prep").doc("id").set(dto);
  }

  Future<PrepDetail> getPrepDetail() async {
    final response = await firestoreInstance.collection("prep").doc("id").get();
    return PrepDetail.fromDocumentSnap(response);
  }

  Stream<List<PrepDetail>> getPrepStream()  {
   final response =  firestoreInstance.collection("prep").snapshots();
   
   final listResp = response.map(
          (event) => event.docs.map(
            (queryDocSnap) => PrepDetail.fromQueryDocumentSnap(queryDocSnap),
          ).toList());
    return listResp;
  }
}

final strmPrvder = StreamProvider<List<PrepDetail>>((ref) {
  final fs = FirestoreService();
   return fs.getPrepStream();
});