import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';

class FilePickerWidget extends StatelessWidget {
  String nameFile;
  FilePickerWidget({required this.nameFile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nameFile,
          style: TextStyle(color: CustomColor.grey),
        ),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Browse',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: Commons.blueButtonStyle),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Example',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: Commons.blueButtonStyle)
            ],
          ),
        )
      ],
    );
  }
}
