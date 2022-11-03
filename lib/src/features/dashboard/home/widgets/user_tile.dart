import 'package:flutter/material.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/view/secondary_profile_view.dart';

class MarketUserTile extends StatelessWidget {
  const MarketUserTile({required this.user, super.key});
  final MarketUser user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(user.marketName),
        subtitle: Text(user.email),
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondaryProfileView(
                  secondaryUser: user,
                ),
              ));
        });
  }
}
