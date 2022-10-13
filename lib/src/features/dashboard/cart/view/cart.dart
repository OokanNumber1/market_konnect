import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:market_connect/src/utilities/insets/insets.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Padding(
      padding: const EdgeInsets.all(Insets.large),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("C A R T    V I E W")],
      ),
    ),);
  }
}