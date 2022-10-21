import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/authentication/view_model/auth_vm.dart';
import 'package:market_connect/src/features/authentication/views/signin_view.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/follow_display.dart';
import 'package:market_connect/src/features/dashboard/profile/widgets/profile_avatar_card.dart';
import 'package:market_connect/src/utilities/enums/enums.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
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
    debugPrint("In the ChangeDependencies");
    super.didChangeDependencies();
    ref
        .read(profileVmProvider.notifier)
        .getUser(ref.read(authChangeProvider).value!.uid);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(profileVmProvider);
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
      body: Padding(
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
                ProfileAvatar(fullName: user.fullName),
                FollowDisplay(
                  user: user,
                  label: "Followers",
                  value: user.followers.length,
                )
              ],
            ),
            Spacing.vertical(height: 8),
            Text(user.about),
            Spacing.vertical(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Edit Profile",
              ),
            ),
            Spacing.vertical(height: 24),
          ],
        ),
      ),
    );
  }
}
