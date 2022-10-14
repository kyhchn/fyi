import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';

class Commons {
  static final blueButtonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 0, horizontal: 3)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      backgroundColor: MaterialStateProperty.all(CustomColor.lightBlue));
  static final hintStyle = TextStyle(color: CustomColor.grey);
  static String lorem =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Molestie ac feugiat sed lectus vestibulum mattis ullamcorper. Dui id ornare arcu odio ut sem nulla ';
}
