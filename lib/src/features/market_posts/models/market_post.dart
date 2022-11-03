import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:market_connect/src/features/market_posts/models/comment.dart';

class MarketPost {
  MarketPost({
    required this.authorId,
    required this.postId,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.imageUrl,
    required this.createdAt,
  });
  final String authorId;
  final String postId;
  final String imageUrl;
  final String caption;
  final DateTime createdAt;
  final List likes;
  final List<Comment> comments;

  factory MarketPost.empty() => MarketPost(
        authorId: "",
        postId: "",
        caption: "",
        likes: [],
        comments: [],
        imageUrl: "",
        createdAt: DateTime.now(),
      );

  Map<String, dynamic> toMap() {
    return {
      'author': authorId,
      'caption': caption,
      'postId': postId,
      'imageUrl': imageUrl,
      'likes': likes,
      'createdAt': createdAt,
      'comments': comments.map((x) => x.toMap()).toList(),
    };
  }

  factory MarketPost.fromMap(Map<String, dynamic> map) {
    return MarketPost(
      authorId: map['author'] ?? '',
      postId: map['postId'],
      caption: map['caption'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      likes: map['likes'] ?? [],
      comments:
          List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory MarketPost.fromJson(String source) =>
      MarketPost.fromMap(json.decode(source));

  MarketPost copyWith({
    String? authorId,
    String? postId,
    String? imageUrl,
    String? caption,
    List? likes,
    List<Comment>? comments,
    DateTime? createdAt,
  }) {
    return MarketPost(
      postId: postId ?? this.postId,
      authorId: authorId ?? this.authorId,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }
}
