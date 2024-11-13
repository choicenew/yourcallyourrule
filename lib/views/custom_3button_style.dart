import 'package:flutter/material.dart';

class Custom3ButtonStyle {

  static const double buttonFontSize = 16.0;
  static const double iconSize = 20.0;
  static const double borderRadius = 15.0;

  static final ButtonStyle style = ButtonStyle(

    textStyle: WidgetStateProperty.all<TextStyle>(
      const TextStyle(fontSize: buttonFontSize),
    ),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
    ),
    minimumSize: WidgetStateProperty.all<Size>(const Size(88, 36)),
  );
}
