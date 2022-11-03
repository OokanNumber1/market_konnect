import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/dashboard/profile/view/profile_post_view.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/follow_display.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/profile_avatar_card.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

import '../../../../utilities/widgets/asyncwidgets.dart';
import '../../../market_posts/view_model/market_post_vm.dart';
import '../widgets/profile_post_card.dart';

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
    final profilePosts =
        ref.watch(profilePostsVmProvider(widget.secondaryUser.uid));
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
      body: tempPryUser == MarketUser.empty()
          ? const Center(
              child: LinearProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Insets.medium),
                  child: Column(
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
                      Spacing.vertical(8),
                      Text(widget.secondaryUser.about),
                      Spacing.vertical(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: follow,
                            style: ElevatedButton.styleFrom(),
                            child: Text(tempPryUser.following
                                    .contains(widget.secondaryUser.uid)
                                ? "Unfollow"
                                : tempPryUser.followers.contains(
                                            widget.secondaryUser.uid) &&
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
                Spacing.vertical(24),
                const Divider(thickness: 2),
                const Text(
                  "Posts",
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(thickness: 2),
                profilePosts.when(
                  data: (posts) => posts.isEmpty
                      ? const Center(
                          child: Text("No Post Currently"),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.672,
                            children: List.generate(
                              posts.length,
                              (index) => GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePostView(
                                      user: widget.secondaryUser,
                                    ),
                                  ),
                                ),
                                child: ProfilePostCard(
                                  post: posts[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                  error: (error, stacktrace) => AsyncErrorWidget(
                      ref: ref,
                      onRefresh: () => ref.refresh(
                            profilePostsVmProvider(widget.secondaryUser.uid),
                          ),
                      errorMessage: "Error Occured, Try Again"),
                  loading: () => const AsyncLoadingWidget(),
                )
              ],
            ),
    );
  }
}
