import 'package:flutter/material.dart';

class ElevButton extends StatelessWidget {
  const ElevButton({
    super.key,
    required this.isLoading,
    required this.label,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final String label;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(label),
    );
  }
}
