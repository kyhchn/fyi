import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/ui/startup/funding_page.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class FilePickerWidget extends StatelessWidget {
  String nameFile;
  FilePickerWidget({super.key, required this.nameFile});
  var isPicked = false.obs;
  late File file;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              nameFile,
              style: TextStyle(color: CustomColor.grey),
            ),
            Obx(
              () => Icon(
                Icons.verified,
                color: isPicked.value ? Colors.green : CustomColor.grey,
              ),
            )
          ],
        ),
        SizedBox(
          height: 40,
          child: Row(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            allowedExtensions: ['pdf'], type: FileType.custom);
                    if (result != null) {
                      file = File(result.files.single.path!);
                      isPicked.value = true;
                    }
                  },
                  child: Text(
                    'Browse',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: Commons.blueButtonStyle),
              SizedBox(
                width: 10,
              ),
              Obx(
                () => ElevatedButton(
                    onPressed: isPicked.value
                        ? () async {
                            OpenFilex.open(file!.path);
                          }
                        : null,
                    child: Text(
                      'Example',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: Commons.blueButtonStyle),
              )
            ],
          ),
        )
      ],
    );
  }
}
