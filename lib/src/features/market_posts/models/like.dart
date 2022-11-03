import 'dart:convert';

class Like {
  final String userId;
  Like({
    required this.userId,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
    };
  }

  factory Like.fromMap(Map<String, dynamic> map) {
    return Like(
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Like.fromJson(String source) => Like.fromMap(json.decode(source));
}
