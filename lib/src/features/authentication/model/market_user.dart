import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class MarketUser {
  const MarketUser({
    required this.email,
    required this.uid,
    required this.marketName,
    required this.fullName,
    required this.about,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });
  final String email;
  final String uid;
  final String marketName;
  final String fullName;
  final String about;
  final String photoUrl;
  final List followers;
  final List following;

  factory MarketUser.empty() {
    return const MarketUser(
      email: "",
      uid: "",
      about: "",
      marketName: "",
      fullName: "",
      photoUrl: "",
      followers: [],
      following: [],
    );
  }

  Map<String, dynamic> toMap([e]) {
    return {
      'email': email,
      'uid': uid,
      'bio': about,
      'marketName': marketName,
      'fullName': fullName,
      'followers': followers,
      'following': following,
      'photoUrl': photoUrl,
    };
  }

  factory MarketUser.fromMap(Map<String, dynamic> map) {
    return MarketUser(
      email: map['email'] ?? '',
      about: map['about'] ?? '',
      uid: map['uid'] ?? '',
      marketName: map['marketName'] ?? '',
      fullName: map['fullName'] ?? '',
      photoUrl: map['photoUrl'],
      followers: map['followers'] ?? [],
      following: map['following'] ?? [],
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

  @override
  String toString() {
    return 'MarketUser(email: $email, uid: $uid, marketName: $marketName, fullName: $fullName, about: $about, followers: $followers, following: $following, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MarketUser &&
      other.email == email &&
      other.uid == uid &&
      other.marketName == marketName &&
      other.fullName == fullName &&
      other.about == about &&
      listEquals(other.followers, followers) &&
      listEquals(other.following, following);
  }

  @override
  int get hashCode {
    return email.hashCode ^
      uid.hashCode ^
      marketName.hashCode ^
      fullName.hashCode ^
      about.hashCode ^
      followers.hashCode ^
      following.hashCode;
  }

  MarketUser copyWith({
    String? email,
    String? uid,
    String? marketName,
    String? fullName,
    String? about,
    String? photoUrl,
    List? followers,
    List? following,
  }) {
    return MarketUser(
      email: email ?? this.email,
      uid: uid ?? this.uid,
      marketName: marketName ?? this.marketName,
      fullName: fullName ?? this.fullName,
      about: about ?? this.about,
      photoUrl: photoUrl ?? this.photoUrl,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }
}
