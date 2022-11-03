import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class ProfileAvatar extends ConsumerStatefulWidget {
  const ProfileAvatar({required this.user, super.key});
  final MarketUser user;

  @override
  ConsumerState<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends ConsumerState<ProfileAvatar> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final profileVM = ref.watch(profileVmProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CircleAvatar(
                    radius: 32,
                    backgroundImage:
                        CachedNetworkImageProvider(widget.user.photoUrl),
                  ),
            widget.user == profileVM
                ? Positioned(
                    child: GestureDetector(
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await ref
                            .read(profileVmProvider.notifier)
                            .uploadProfileImage(profileVM.uid);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.grey[50],
                        child: const Icon(
                          Icons.add,
                          size: 14,
                          color: MarketKonnetColor.primary,
                        ),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        Spacing.vertical(Insets.tiny),
        Text(
          widget.user.fullName,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
