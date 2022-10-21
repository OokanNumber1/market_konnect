import 'package:flutter/material.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({required this.fullName, super.key});
  final String fullName;
  //TODO Add avatar here too

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircleAvatar(
          radius: 32,
        ),
        Spacing.vertical(height: Insets.tiny),
        Text(fullName, style: Theme.of(context).textTheme.bodyLarge,)
      ],
    );
  }
}
