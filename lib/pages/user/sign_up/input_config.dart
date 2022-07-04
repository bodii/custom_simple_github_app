import 'package:flutter/material.dart';

class InputConfig {
  bool visible;
  Text prefix = defaultPrefix;
  Color suffixColor = defaultSuffixColor;
  bool obscure;
  bool buttonVisible;

  static Text get defaultPrefix => const Text(
        '→',
        style: TextStyle(
          color: Color.fromRGBO(235, 83, 174, 1.0),
          fontSize: 15.0,
        ),
      );
  static Text get successPrefix => const Text(
        '✓',
        style: TextStyle(
          color: Colors.lightGreen,
          fontSize: 15.0,
        ),
      );
  static Color get defaultSuffixColor => Colors.white60;
  static Color get successSuffixColor => Colors.lightGreen;

  InputConfig({
    required this.visible,
    this.obscure = false,
    this.buttonVisible = true,
  });
}
