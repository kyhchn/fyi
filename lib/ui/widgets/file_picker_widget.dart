import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class FilePickerWidget extends StatelessWidget {
  String nameFile;
  String examplePath;
  FilePickerWidget(
      {super.key, required this.nameFile, required this.examplePath});
  var isPicked = false.obs;
  File? file;
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
                  style: Commons.blueButtonStyle,
                  child: const Text(
                    'Browse',
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await OpenFilex.open(examplePath);
                  },
                  style: Commons.blueButtonStyle,
                  child: const Text(
                    'Example',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        )
      ],
    );
  }
}
