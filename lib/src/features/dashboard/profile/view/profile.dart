import 'package:flutter/material.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("P R O F I L E    V I E W")],
        ),
      ),
    );
  }
}
