import 'package:flutter/material.dart';

class ReachOutBox extends StatelessWidget {
  const ReachOutBox(
      {required this.iAmSender, required this.content, super.key});
  final bool iAmSender;
  final String content;
  @override
  Widget build(BuildContext context) {
    return 
    
    Align(
      alignment: iAmSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        alignment: iAmSender ? Alignment.centerRight : Alignment.centerLeft,
        constraints:
            BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.76),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight:
                  iAmSender ? const Radius.circular(2) : const Radius.circular(8),
              bottomRight:
                  iAmSender ? const Radius.circular(2) : const Radius.circular(8),
              topLeft:
                  iAmSender ? const Radius.circular(8) : const Radius.circular(2),
              bottomLeft:
                  iAmSender ? const Radius.circular(8) : const Radius.circular(2),
            ),
            color: iAmSender ? Colors.brown.shade100 : Colors.brown.shade200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          content,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
    
  }
}
