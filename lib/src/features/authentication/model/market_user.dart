import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MarketUser {
  const MarketUser({
    required this.email,
    required this.uid,
    required this.marketName,
    required this.fullName,
  });
  final String email;
  final String uid;
  final String marketName;
  final String fullName;

  factory MarketUser.empty() {
    return const MarketUser(
      email: "",
      uid: "",
      marketName: "",
      fullName: "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'marketName': marketName,
      'fullName': fullName,
    };
  }

  factory MarketUser.fromMap(Map<String, dynamic> map) {
    return MarketUser(
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      marketName: map['marketName'] ?? '',
      fullName: map['fullName'] ?? '',
    );
  }

  factory MarketUser.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> docSnap) {
    final data = docSnap.data();
    return MarketUser.fromMap(data ?? {});
  }

  String toJson() => json.encode(toMap());

  factory MarketUser.fromJson(String source) =>
      MarketUser.fromMap(json.decode(source));
}
