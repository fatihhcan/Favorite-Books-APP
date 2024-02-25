import 'package:flutter/material.dart';

extension SVGImagePathExtension on String {
  String get toJPEG => 'assets/images/$this.jpeg';
}

extension StringColorExtension on String {
  Color get color => Color(int.parse('0xff$this'));
}

