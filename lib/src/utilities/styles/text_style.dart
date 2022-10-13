import 'package:flutter/material.dart';

class TextStyles {
  static get smallNormal => const TextStyle(fontSize: 12);
  static get mediumNormal => const TextStyle(fontSize: 16);
  static get largeNormal => const TextStyle(fontSize: 24);

  static get smallBold => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      );
  static get mediumBold => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static get largeBold => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
}
