import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/views/signin_view.dart';
import 'package:market_connect/src/features/dashboard/view/dashboard_view.dart';

import 'src/features/authentication/repository/auth_repo.dart';

class MarketKonnet extends ConsumerWidget {
  const MarketKonnet({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authRepoProvider).currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market Konnect',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: currentUser?.emailVerified == true ? const DashboardView() :const SignInView() ,
    );
  }
}