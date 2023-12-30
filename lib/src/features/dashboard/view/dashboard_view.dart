import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/repository/auth_repo.dart';
import 'package:market_connect/src/features/dashboard/profile/view_model/profile_vm.dart';
import 'package:market_connect/src/features/dashboard/widget/navbar_item.dart';
import 'package:market_connect/src/features/dashboard/home/view/home.dart';
import 'package:market_connect/src/features/dashboard/profile/view/primary_profile_view.dart';
import 'package:market_connect/src/features/dashboard/reach_out/view/reach_out.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

typedef PageType<T> = Function(
    {required String label, required Widget screen, required IconData icon});

class _DashboardViewState extends ConsumerState<DashboardView> {
  int indexOfNavBar = 0;

  @override
  void initState() {
    ref
        .read(profileVmProvider.notifier)
        .getUser(ref.read(authChangeProvider).value!.uid);
    super.initState();
  }

  void setIndexOfNavbar(int value) => setState(() {
        indexOfNavBar = value;
      });
  @override
  Widget build(BuildContext context) {
    const pages = [
      {"page": HomeView(), "icon": Icons.home, "label": "Home"},
      {"page": ReachOutView(), "icon": Icons.message, "label": "Reach Out"},
      {"page": PrimaryProfileView(), "icon": Icons.person, "label": "Profile"},
    ];

    return Scaffold(
      body: pages[indexOfNavBar]["page"] as Widget,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            pages.length,
            (index) => GestureDetector(
              onTap: () => setIndexOfNavbar(index),
              child: NavbarItem(
                color: indexOfNavBar == index
                    ? Colors.brown[300]!
                    : Colors.brown[100]!,
                label: pages[index]["label"] as String,
                icon: pages[index]["icon"] as IconData,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
