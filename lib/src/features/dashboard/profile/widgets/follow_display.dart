import 'package:flutter/material.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/view/follow_details_view.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class FollowDisplay extends StatelessWidget {
  const FollowDisplay(
      {required this.user,
      required this.label,
      required this.value,
      super.key});
  final int value;
  final String label;
  final MarketUser user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FollowDetailsView(user: user),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(value.toString(),
                  style: Theme.of(context).textTheme.titleLarge),
              Spacing.vertical(height: 4),
              Text(label, style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ),
      ),
    );
  }
}
