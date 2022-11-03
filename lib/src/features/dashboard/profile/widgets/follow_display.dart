import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/view/follow_details_view.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

import '../../../authentication/repository/auth_repo.dart';

class FollowDisplay extends ConsumerStatefulWidget {
  const FollowDisplay(
      {required this.user,
      required this.label,
      required this.value,
      super.key});
  final int value;
  final String label;
  final MarketUser user;

  @override
  ConsumerState<FollowDisplay> createState() => _FollowDisplayState();
}

class _FollowDisplayState extends ConsumerState<FollowDisplay> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FollowDetailsView(user: widget.user),
        ),
      ).then(
        (value) => setState(() {
          ref
              .read(profileVmProvider.notifier)
              .getUser(ref.read(authChangeProvider).value!.uid);
        }),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.value.toString(),
                  style: Theme.of(context).textTheme.titleLarge),
              Spacing.vertical( 4),
              Text(widget.label, style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
        ),
      ),
    );
  }
}
