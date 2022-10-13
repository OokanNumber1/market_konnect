import 'package:flutter/material.dart';
import 'package:market_connect/market_konnet.dart';

import 'package:market_connect/src/utilities/insets/insets.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Insets.large),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("H O M E    V I E W")],
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
