import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/authentication/view_model/auth_vm.dart';
import 'package:market_connect/src/features/authentication/views/signin_view.dart';
import 'package:market_connect/src/features/dashboard/profile/view/profile_post_view.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/follow_display.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/profile_avatar_card.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/profile_post_card.dart';
import 'package:market_connect/src/features/market_posts/view_model/market_post_vm.dart';
import 'package:market_connect/src/features/market_posts/views/add_post.dart';
import 'package:market_connect/src/utilities/enums/enums.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/widgets/asyncwidgets.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class PrimaryProfileView extends ConsumerStatefulWidget {
  const PrimaryProfileView({super.key});

  @override
  ConsumerState<PrimaryProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<PrimaryProfileView> {
  @override
  void initState() {
    ref
        .read(profileVmProvider.notifier)
        .getUser(ref.read(authChangeProvider).value!.uid);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref
        .read(profileVmProvider.notifier)
        .getUser(ref.read(authChangeProvider).value!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileVmProvider);
    final profilePosts = ref.watch(profilePostsVmProvider(user.uid));
    ref.listen(authVmProvider, (previous, state) {
      if (state.authViewState == ViewState.success) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignInView()),
            (route) => false);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(user.marketName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => ref.read(authVmProvider.notifier).signOut(),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.medium),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FollowDisplay(
                        user: user,
                        label: "Following",
                        value: user.following.length,
                      ),
                      ProfileAvatar(user: user),
                      FollowDisplay(
                        user: user,
                        label: "Followers",
                        value: user.followers.length,
                      )
                    ],
                  ),
                  Spacing.vertical(8),
                  Text(user.about),
                  Spacing.vertical(8),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Edit Profile",
                    ),
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
                                builder: (context) =>
                                    ProfilePostView(user: user),
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
                        profilePostsVmProvider(user.uid),
                      ),
                  errorMessage: "Error Occured, Try Again"),
              loading: () => const AsyncLoadingWidget(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddMarketPost()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
