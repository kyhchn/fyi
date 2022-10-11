import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';

class Commons {
  static final myTextStyle = const TextStyle(color: Colors.white);
  static final blueButtonStyle = ButtonStyle(
      padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 0, horizontal: 3)),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      backgroundColor: MaterialStateProperty.all(CustomColor.lightBlue));
  static final hintStyle = TextStyle(color: CustomColor.grey);
}
