import 'package:cloud_firestore/cloud_firestore.dart';

class ReachOut {
  const ReachOut({
    required this.content,
    required this.receiverId,
    required this.senderId,
    required this.dateTime,
  });
  final String content;
  final DateTime dateTime;
  final String senderId, receiverId;

  Map<String, dynamic> toMap() {
    return {
      "content": content,
      "receiverId": receiverId,
      "senderId": senderId,
      "dateTime": dateTime,
    };
  }

  factory ReachOut.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    return ReachOut(
      content: data["content"],
      receiverId: data["receiverId"],
      senderId: data["senderId"],
      dateTime: DateTime.parse((data["dateTime"] as Timestamp).toDate().toString()),
    );
  }
}
