// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/view_model/auth_vm.dart';
import 'package:market_connect/src/features/authentication/views/signup_view.dart';
import 'package:market_connect/src/features/dashboard/view/dashboard_view.dart';
import 'package:market_connect/src/utilities/enums/enums.dart';
import 'package:market_connect/src/utilities/validator/validator.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';
import 'package:market_connect/src/utilities/widgets/text_input_field.dart';

class SignInView extends HookConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final isPasswordVisible = useState(true);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    ref.listen(authVmProvider, (previous, state) {
      if (state.authViewState == ViewState.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardView(),
          ),
        );
      } else if (state.authViewState == ViewState.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.errorMessage!),
          ),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextInputField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (input) => Validator.characterLength(
                      input: input,
                      minimumLength: 11,
                      errorMessage: "Enter a valid mail address",
                    ),
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email),
                  ),
                  Spacing.vertical(32),
                  TextInputField(
                    controller: passwordController,
                    labelText: "Password",
                    validator: (input) =>
                        Validator.characterLength(input: input),
                    prefixIcon: const Icon(Icons.password),
                    obscureText: isPasswordVisible.value,
                    suffixIcon: IconButton(
                      onPressed: () =>
                          isPasswordVisible.value = !isPasswordVisible.value,
                      icon: Icon(isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  Spacing.vertical(40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        ref.read(authVmProvider.notifier).emailPasswordSignIn(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                      }
                    },
                    child: ref.watch(authVmProvider).authViewState ==
                            ViewState.loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('SignIn With Email'),
                  ),
                  Spacing.vertical(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("You don't have an account ?"),
                      TextButton(
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpView(),
                          ),
                        ),
                        child: const Text("SignUp"),
                      )
                    ],
                  ),
                  Spacing.vertical(24),
                  /*   ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(double.maxFinite, 48),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Colors.brown),
                      ),
                    ),
                    onPressed: () =>
                        ref.read(authVmProvider.notifier).googleSignIn(),
                    child: ref.watch(authVmProvider).authViewState ==
                            ViewState.loading
                        ? const LinearProgressIndicator(color: Colors.brown)
                        : const Text(
                            "Continue with Google Account",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.brown,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
