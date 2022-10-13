import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/auth_state.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/authentication/view_model/auth_vm.dart';
import 'package:market_connect/src/features/authentication/views/signin_view.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signedIn = ref.read(currentUser);
    final authVM = ref.read(authVmProvider.notifier);

    ref.listen(authVmProvider, (previous, state) {
      if (state.authViewState == ViewState.success) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInView(),
            ),
            (route) => false);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${signedIn!.uid}",
          style: const TextStyle(fontSize: 12),
        ),
        actions: [
          TextButton(
            onPressed: () => authVM.signOut(),
            child: const Text(
              "Sign out",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(children: const []),
    );
  }
}
