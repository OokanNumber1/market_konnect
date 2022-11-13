import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:market_connect/src/features/authentication/model/signup_dto.dart';
import 'package:market_connect/src/features/authentication/view_model/auth_vm.dart';
import 'package:market_connect/src/features/authentication/views/signin_view.dart';
import 'package:market_connect/src/features/dashboard/view/dashboard_view.dart';
import 'package:market_connect/src/utilities/enums/enums.dart';
import 'package:market_connect/src/utilities/validator/validator.dart';
import 'package:market_connect/src/utilities/widgets/spacing.dart';
import 'package:market_connect/src/utilities/widgets/text_input_field.dart';

class SignUpView extends HookConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    final isPasswordVisible = useState(true);
    final isConfirmPasswordVisible = useState(true);
    final withGoogle = useState(false);

    final authVM = ref.watch(authVmProvider);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final marketNameController = useTextEditingController();
    final fullNameController = useTextEditingController();

    ref.listen(authVmProvider, (previous, state) {
      if (state.authViewState == ViewState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Kindly check email provided to verify your email before signing in.",
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                withGoogle.value ? const DashboardView() : const SignInView(),
          ),
        );
      } else if (state.authViewState == ViewState.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.errorMessage!)),
        );
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacing.vertical(48),
                TextInputField(
                  controller: fullNameController,
                  validator: (input) => Validator.empty(input: input),
                  labelText: "Fullname",
                  prefixIcon: const Icon(
                    Icons.details,
                  ),
                ),
                Spacing.vertical(32),
                TextInputField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
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
                  controller: marketNameController,
                  validator: (input) => Validator.characterLength(
                    input: input,
                    minimumLength: 4,
                    errorMessage: "MarketName must be at least 4 characters",
                  ),
                  labelText: "MarketName",
                  prefixIcon: const Icon(
                    Icons.details,
                  ),
                ),
                Spacing.vertical(32),
                TextInputField(
                  controller: passwordController,
                  labelText: "Password",
                  validator: (input) => Validator.characterLength(input: input),
                  prefixIcon: const Icon(Icons.email),
                  obscureText: isPasswordVisible.value,
                  suffixIcon: IconButton(
                    onPressed: () =>
                        isPasswordVisible.value = !isPasswordVisible.value,
                    icon: Icon(
                      isPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                  ),
                ),
                Spacing.vertical(32),
                TextInputField(
                  controller: confirmPasswordController,
                  validator: (input) => Validator.confirmPassword(
                    input: input,
                    password: passwordController.text,
                  ),
                  labelText: "Confirm Password",
                  prefixIcon: const Icon(Icons.password),
                  obscureText: isConfirmPasswordVisible.value,
                  suffixIcon: IconButton(
                    onPressed: () => isConfirmPasswordVisible.value =
                        !isConfirmPasswordVisible.value,
                    icon: Icon(isConfirmPasswordVisible.value
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
                      ref.read(authVmProvider.notifier).emailPasswordSignUp(
                            SignupDTO(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              marketName: marketNameController.text.trim(),
                              fullName: fullNameController.text.trim(),
                            ),
                          );
                    }
                  },
                  child: authVM.authViewState == ViewState.loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('SignUp With Email'),
                ),
                Spacing.vertical(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You have an account ?"),
                    TextButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInView(),
                        ),
                      ),
                      child: const Text("SignIn"),
                    )
                  ],
                ),
                Spacing.vertical(24),
                /*ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(double.maxFinite, 48),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Colors.brown),
                    ),
                  ),
                  onPressed: () {
                    withGoogle.value = true;
                    ref.read(authVmProvider.notifier).googleSignIn();
                  },
                  child: authVM.authViewState == ViewState.loading
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
    );
  }
}
