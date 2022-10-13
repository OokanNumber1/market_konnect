import 'package:flutter/material.dart';

class NavbarItem extends StatelessWidget {
  const NavbarItem({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
  }) : super(key: key);
  final String label;
  final IconData icon;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          Text(
            label,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
