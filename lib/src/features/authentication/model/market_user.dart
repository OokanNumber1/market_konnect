import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MarketUser {
  const MarketUser({
    required this.email,
    required this.uid,
    required this.marketName,
    required this.fullName,
    required this.followers,
    required this.following,
  });
  final String email;
  final String uid;
  final String marketName;
  final String fullName;
  final int followers;
  final int following;

  factory MarketUser.empty() {
    return const MarketUser(
      email: "",
      uid: "",
      marketName: "",
      fullName: "",
      followers: 0,
      following: 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'marketName': marketName,
      'fullName': fullName,
      'followers': followers,
      'following': following
    };
  }

  factory MarketUser.fromMap(Map<String, dynamic> map) {
    return MarketUser(
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      marketName: map['marketName'] ?? '',
      fullName: map['fullName'] ?? '',
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
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
