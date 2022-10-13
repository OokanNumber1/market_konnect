import 'package:flutter/material.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';

class ReachOutView extends StatelessWidget {
  const ReachOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
      padding: const EdgeInsets.all(Insets.large),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("R E A C H  O U T    V I E W")],
      ),
    ),);
  }
}
