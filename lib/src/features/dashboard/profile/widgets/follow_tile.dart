import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/dashboard/profile/view/secondary_profile_view.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/follow_vm.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';

enum FollowType { following, followers }

class FollowTile extends ConsumerStatefulWidget {
  const FollowTile({
    required this.uid,
    super.key,
  });

  final String uid;

  @override
  ConsumerState<FollowTile> createState() => _FollowTileState();
}

class _FollowTileState extends ConsumerState<FollowTile> {
  @override
  Widget build(BuildContext context) {
    final followVM = ref.watch(followVmProvider(widget.uid));
    return followVM.when(
      data: (user) => ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondaryProfileView(secondaryUser: user),
          ),
        ),
        title: Text(
          user.marketName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(user.fullName),
        leading: const CircleAvatar(radius: 16),
        trailing: Consumer(builder: (context, ref, child) {
          final profileVM = ref.watch(profileVmProvider);
          final tempPryUser = profileVM;
          void follow() {
            ref
                .read(profileVmProvider.notifier)
                .follow(profileVM.uid, user.uid);
            if (tempPryUser.following.contains(user.uid)) {
              tempPryUser.following.remove(user.uid);
              user.followers.remove(tempPryUser.uid);
            } else {
              tempPryUser.following.add(user.uid);
              user.followers.add(tempPryUser.uid);
            }
            setState(() {});
          }

          return user == tempPryUser
              ? const SizedBox()
              : ElevatedButton(
                  onPressed: follow,
                  child: Text(tempPryUser.following.contains(user.uid)
                      ? "Unfollow"
                      : tempPryUser.followers.contains(user.uid) &&
                              !tempPryUser.following.contains(user.uid)
                          ? "Follow Back"
                          : "Follow"),
                );
        }),
      ),
      error: (err, skt) => const Center(
        child: Text("Error ocurred try again"),
      ),
      loading: () => const Center(
        child: LinearProgressIndicator(),
      ),
    );
  }
}
