import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/startup_user.dart';
import 'package:fyi/services/cloud_storage_service.dart';
import 'package:fyi/services/startup_service.dart';
import 'package:fyi/ui/widgets/loading_alert.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:open_filex/open_filex.dart';

class UpdateStartupProfile extends StatelessWidget {
  StartupUser user;
  UpdateStartupProfile({super.key, required this.user});
  File? imageFile;
  final imageFileIsPicked = false.obs;
  @override
  Widget build(BuildContext context) {
    final nameEditingController = TextEditingController(text: user.name).obs;
    final instagramEditingController =
        TextEditingController(text: user.instagramLink).obs;
    final twitterEditingController =
        TextEditingController(text: user.twitterLink).obs;
    final linkedinEditingController =
        TextEditingController(text: user.linkedinLink).obs;
    final descriptionEditingController =
        TextEditingController(text: user.description).obs;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15), right: Radius.circular(15))),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Profile',
          style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name'),
              TextFormField(
                controller: nameEditingController.value,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Profile Image',
                        style: TextStyle(color: CustomColor.grey),
                      ),
                      Icon(
                        Icons.verified,
                        color: imageFileIsPicked.value
                            ? Colors.green
                            : CustomColor.grey,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                      allowedExtensions: ['png', 'jpg', 'jpeg'],
                                      type: FileType.custom);
                              if (result != null) {
                                imageFile = File(result.files.single.path!);
                                imageFileIsPicked.value = true;
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
                            onPressed: imageFileIsPicked.value
                                ? () async {
                                    OpenFilex.open(imageFile!.path);
                                  }
                                : null,
                            style: Commons.blueButtonStyle,
                            child: const Text(
                              'Preview',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'About us', hintStyle: Commons.hintStyle),
                controller: descriptionEditingController.value,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Instagram Link', hintStyle: Commons.hintStyle),
                controller: instagramEditingController.value,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Twitter Link', hintStyle: Commons.hintStyle),
                controller: twitterEditingController.value,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'Linkedin Link', hintStyle: Commons.hintStyle),
                controller: linkedinEditingController.value,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    showDialog(
                      context: context,
                      builder: (context) =>
                          LoadingAlert(message: 'Updating Profile'),
                    );
                    if (imageFile != null) {
                      final pathRes =
                          await CloudStorageService(file: imageFile!)
                              .uploadImage("users/startup/${user.uid}");
                      if (pathRes != null) {
                        user.profileImage = pathRes;
                      }
                    }
                    user.name = nameEditingController.value.text;
                    user.description = descriptionEditingController.value.text;
                    user.instagramLink =
                        instagramEditingController.value.text.isNotEmpty
                            ? instagramEditingController.value.text
                            : null;
                    user.linkedinLink =
                        linkedinEditingController.value.text.isNotEmpty
                            ? linkedinEditingController.value.text
                            : null;
                    user.twitterLink =
                        twitterEditingController.value.text.isNotEmpty
                            ? twitterEditingController.value.text
                            : null;
                    await StartupService().updateUser(user);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: Commons.blueButtonStyle,
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
