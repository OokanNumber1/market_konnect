import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/dashboard/reach_out/viewmodel/reach_out_vm.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';

class ReachOutView extends ConsumerWidget {
  const ReachOutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reachOutStreamProvider = ref.watch(reachOutOverviewProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(Insets.large),
        child: reachOutStreamProvider.when(
          data: (overviews) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: overviews.isEmpty
                ? [
                    Text("No reach out yet"),
                    ElevatedButton(
                        onPressed: () {
                          ref.refresh(reachOutOverviewProvider);
                          // ref.read(reachOutVMProvider).getReachOutOverview(
                          //     ref.read(currentUser)?.uid ?? "");
                        },
                        child: const Text("Reload")),
                  ]
                : List.generate(
                    overviews.length,
                    (index) => Text(overviews[index]),
                  ),
          ),
          error: (err, stkTc) => Text(err.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
