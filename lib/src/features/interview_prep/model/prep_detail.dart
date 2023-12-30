import 'package:cloud_firestore/cloud_firestore.dart';

class PrepDetail {
  const PrepDetail({
    required this.address,
    required this.email,
    required this.name,
    required this.phone,
  });
  final String address, email, name, phone;

  factory PrepDetail.fromDocumentSnap(
      DocumentSnapshot<Map<String, dynamic>> docRef) {
    final data = docRef.data();
    return PrepDetail(
      address: data?["address"] ?? "",
      email: data?["email"] ?? "",
      name: data?["name"] ?? "",
      phone: data?["phone"] ?? "",
    );
  }
  
  factory PrepDetail.fromQueryDocumentSnap(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocSnap) {
    final data = queryDocSnap.data();
    return PrepDetail(
      address: data["address"]??"",
      email: data["email"]??"",
      name: data["name"]??"",
      phone: data["phone"]??"",
    );
  }
}
