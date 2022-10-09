import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              final userCred = await FirebaseAuth.instance.signInAnonymously();

              print("UserCred ==>> ${userCred.user!.uid}");
            },
            child: const Text('Anonymous Login')),
      ),
    );
  }
}
