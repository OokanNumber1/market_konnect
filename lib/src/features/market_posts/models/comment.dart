import 'dart:convert';

class Comment {
  final String author;
  final String content;
  final DateTime time;
  Comment({
    required this.author,
    required this.content,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'content': content,
      'time': time.millisecondsSinceEpoch,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      author: map['author'] ?? '',
      content: map['content'] ?? '',
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source));
}
