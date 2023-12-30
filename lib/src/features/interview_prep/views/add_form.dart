import 'package:flutter/material.dart';
import 'package:market_connect/src/features/interview_prep/firestore_service/firestore_service.dart';
import 'package:market_connect/src/features/interview_prep/viewmodel/prep_viewmodel/prep_vm.dart';
import 'package:market_connect/src/utilities/widgets/button.dart';
import 'package:market_connect/src/utilities/widgets/text_input_field.dart';

class AddFormPage extends StatefulWidget {
  const AddFormPage({super.key});

  @override
  State<AddFormPage> createState() => _AddFormPageState();
}

bool isLoading = false;

class _AddFormPageState extends State<AddFormPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final siblingController = TextEditingController();
  final fatherController = TextEditingController();
  final motherController = TextEditingController();

  void addWithAutoID() {
    setState(() {
      isLoading = true;
    });
    final vm = PrepVM(fService: FirestoreService());

    vm.addFormInAutoDoc({
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "address": addressController.text,
    });

    setState(() {
      isLoading = false;
    });
  }

   void addWithID() {
    setState(() {
      isLoading = true;
    });
    final vm = PrepVM(fService: FirestoreService());

    vm.addFormWithID({
      "name": nameController.text,
      "email": emailController.text,
      "phone": phoneController.text,
      "address": addressController.text,
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextInputField(
                  controller: nameController,
                  labelText: "Name",
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: emailController,
                  labelText: "Email",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  labelText: "Phone Number",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: addressController,
                  labelText: "Address",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: siblingController,
                  labelText: "Sibling Name",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: fatherController,
                  labelText: "Father",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: motherController,
                  labelText: "Mother",
                  prefixIcon: const Icon(
                    Icons.email,
                  ),
                ),
                const SizedBox(height: 32),
                ElevButton(
                  isLoading: isLoading,
                  label: "...WithAutoID",
                  onPressed: addWithAutoID,
                ), const SizedBox(height: 12),
                ElevButton(
                  isLoading: isLoading,
                  label: "...WithID",
                  onPressed: addWithID,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
