import 'package:flutter/material.dart';

class CustomColor {
  static MaterialColor lightBlue = MaterialColor(0xFF48CAE4, color);
  static MaterialColor grey = MaterialColor(0xFFAAAAAA, color);
  static MaterialColor toscaBlue = MaterialColor(0xFFCDF0EA, color);
  static MaterialColor lightGrey = MaterialColor(0xFFF9F9F9, color);
  static MaterialColor pink = MaterialColor(0xFFECC5FB, color);
  static MaterialColor lightYellow = MaterialColor(0xFFFAF4B7, color);
}

Map<int, Color> color = const {
  50: Color.fromRGBO(147, 205, 72, .1),
  100: Color.fromRGBO(147, 205, 72, .2),
  200: Color.fromRGBO(147, 205, 72, .3),
  300: Color.fromRGBO(147, 205, 72, .4),
  400: Color.fromRGBO(147, 205, 72, .5),
  500: Color.fromRGBO(147, 205, 72, .6),
  600: Color.fromRGBO(147, 205, 72, .7),
  700: Color.fromRGBO(147, 205, 72, .8),
  800: Color.fromRGBO(147, 205, 72, .9),
  900: Color.fromRGBO(147, 205, 72, 1),
};
