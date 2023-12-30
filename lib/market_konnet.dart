import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/views/signin_view.dart';
import 'package:market_connect/src/features/dashboard/reach_out/view/reach_out_to_user.dart';
import 'package:market_connect/src/features/dashboard/view/dashboard_view.dart';
import 'package:market_connect/src/utilities/styles/theme.dart';

import 'src/features/authentication/repository/auth_repo.dart';

ThemeData curr = MarketKonnetTheme.lightTheme;

class MarketKonnet extends ConsumerWidget {
  const MarketKonnet({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(authChangeProvider).value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market Konnect',
      // theme: curr,
      theme: MarketKonnetTheme.lightTheme,
      darkTheme: MarketKonnetTheme.darkTheme,
      home: currentUser?.emailVerified == true
          ? const DashboardView()
          : const SignInView(),
      // home: const TstnMessage(),
    );
  }
}
