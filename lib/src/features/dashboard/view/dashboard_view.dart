import 'package:flutter/material.dart';
import 'package:market_connect/src/features/dashboard/widget/navbar_item.dart';
import 'package:market_connect/src/features/dashboard/home/view/home.dart';
import 'package:market_connect/src/features/dashboard/profile/view/profile.dart';
import 'package:market_connect/src/features/dashboard/reach_out/view/reach_out.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int indexOfNavBar = 0;

  void setIndexOfNavbar(int value) => setState(() {
        indexOfNavBar = value;
      });
  @override
  Widget build(BuildContext context) {
    const pages = [
      {"page": HomeView(), "icon": Icons.home, "label": "Home"},
      {"page": ReachOutView(), "icon": Icons.message, "label": "Reach Out"},
      {"page": ProfileView(), "icon": Icons.person, "label": "Profile"},
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
