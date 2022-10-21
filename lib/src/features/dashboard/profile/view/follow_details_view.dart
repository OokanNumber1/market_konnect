import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/follow_tile.dart';

class FollowDetailsView extends ConsumerStatefulWidget {
  const FollowDetailsView({required this.user, super.key});
  final MarketUser user;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FollowDetailsViewState();
}

class _FollowDetailsViewState extends ConsumerState<FollowDetailsView>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(controller: controller, tabs: const [
          Tab(
            text: "Following",
          ),
          Tab(text: "Followers")
        ]),
      ),
      body: TabBarView(controller: controller, children: [
        ListView.builder(
          itemCount: widget.user.following.length,
          itemBuilder: (context, index) => widget.user.following.isEmpty
              ? const Center(
                  child: Text("Not following any marketUser"),
                )
              : FollowTile(
                  uid: widget.user.following[index],
                  //TODO: find a way to solve this overflow
                ),
        ),
        ListView.builder(
          itemCount: widget.user.followers.length,
          itemBuilder: (context, index) => widget.user.followers.isEmpty
              ? const Center(
                  child: Text("Not followed by any marketUser"),
                )
              : FollowTile(
                  uid: widget.user.followers[index],
                ),
        ),
      ]),
    );
  }
}
