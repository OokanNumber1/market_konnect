import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/follow_display.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/profile_avatar_card.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class SecondaryProfileView extends ConsumerStatefulWidget {
  const SecondaryProfileView({required this.secondaryUser, super.key});
  final MarketUser secondaryUser;

  @override
  ConsumerState<SecondaryProfileView> createState() =>
      _SecondaryProfileViewState();
}

class _SecondaryProfileViewState extends ConsumerState<SecondaryProfileView> {
  MarketUser tempPryUser = MarketUser.empty();

  void tempFollow() {
    if (tempPryUser.following.contains(widget.secondaryUser.uid)) {
      tempPryUser.following.remove(widget.secondaryUser.uid);
      widget.secondaryUser.followers.remove(tempPryUser.uid);
    } else {
      tempPryUser.following.add(widget.secondaryUser.uid);
      widget.secondaryUser.followers.add(tempPryUser.uid);
    }
  }

  void follow() {
    ref.read(profileVmProvider.notifier).follow(
        ref.read(authChangeProvider).value!.uid, widget.secondaryUser.uid);
    setState(() {
      tempFollow();
    });
  }

  @override
  Widget build(BuildContext context) {
    tempPryUser = ref.watch(profileVmProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MarketKonnetColor.primary[300],
        title: Text(widget.secondaryUser.marketName),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('holding place'),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Insets.medium),
        child: tempPryUser == MarketUser.empty()
            ? const Center(
                child: LinearProgressIndicator(),
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FollowDisplay(
                        label: "Following",
                        user: widget.secondaryUser,
                        value: widget.secondaryUser.following.length,
                      ),
                      ProfileAvatar(
                        user: widget.secondaryUser,
                      ),
                      FollowDisplay(
                        label: "Followers",
                        user: widget.secondaryUser,
                        value: widget.secondaryUser.followers.length,
                      )
                    ],
                  ),
                  Spacing.vertical(height: 8),
                  Text(widget.secondaryUser.about),
                  Spacing.vertical(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: follow,
                        style: ElevatedButton.styleFrom(),
                        child: Text(tempPryUser.following
                                .contains(widget.secondaryUser.uid)
                            ? "Unfollow"
                            : tempPryUser.followers
                                        .contains(widget.secondaryUser.uid) &&
                                    !tempPryUser.following
                                        .contains(widget.secondaryUser.uid)
                                ? "Follow Back"
                                : "Follow"),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Reach Out"),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
