import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/dashboard/home/widgets/user_tile.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/search_vm.dart';

import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final searchVM = ref.watch(searchVmProvider(searchController.text));
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(Insets.large),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: MarketKonnetColor.primary[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) => setState(() {}),
                    decoration: const InputDecoration(
                      focusedBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                ),
                if (searchController.text.isNotEmpty)
                  searchVM.when(
                    data: (users) {
                      final currentUser = ref.watch(profileVmProvider);

                      if (users.contains(currentUser)) {
                        users.remove(currentUser);
                      }
                      if (users.isEmpty) {
                        return const Text("No MarketUser Found");
                      }
                      return SizedBox(
                        height: screenSize.height * 0.16,
                        child: ListView(
                          children: users
                              .map((user) => MarketUserTile(user: user))
                              .toList(),
                        ),
                      );
                    },
                    error: (error, stk) => Text(error.toString()),
                    loading: () => const CircularProgressIndicator(),
                  ),
                Spacing.vertical(height: 32),
                Container(
                  height: screenSize.height * 0.32,
                  color: Colors.amber,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
