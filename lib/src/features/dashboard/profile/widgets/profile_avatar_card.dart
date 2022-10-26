import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/market_user.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class ProfileAvatar extends ConsumerWidget {
  const ProfileAvatar({required this.user, super.key});
  final MarketUser user;
  //TODO Add avatar here too

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileVM = ref.watch(profileVmProvider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundImage:
                  user.photoUrl.isEmpty ? null : NetworkImage(user.photoUrl),
              radius: 32,
            ),
            user == profileVM
                ? Positioned(
                    child: GestureDetector(
                      onTap: () {
                        ref
                            .read(profileVmProvider.notifier)
                            .uploadProfileImage(profileVM.uid);
                        ref.refresh(profileVmProvider);
                      },
                      child: CircleAvatar(
                        radius: 10,
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
        Spacing.vertical(height: Insets.tiny),
        Text(
          user.fullName,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
