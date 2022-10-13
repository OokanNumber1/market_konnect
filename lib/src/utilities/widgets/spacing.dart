// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';

class Spacing extends SizedBox {
  const Spacing({this.height, this.width, Key? key}) : super(key: key);

  final double? height;
  final double? width;
  factory Spacing.vertical({required double height}) => Spacing(height: height);
  factory Spacing.horizontal(double width) => Spacing(height: width);
}
