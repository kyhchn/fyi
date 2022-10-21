import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/services/investor_service.dart';
import 'package:fyi/ui/general/validation_pending_page.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class VerificationPage extends StatelessWidget {
  User firebaseUser;
  String password, email;
  VerificationPage(
      {super.key,
      required this.firebaseUser,
      required this.password,
      required this.email});
  static late Map<String, String> data;
  final _investorNameEditingController = TextEditingController().obs;
  final _datePickerController = TextEditingController().obs;
  final _emailEditingController = TextEditingController().obs;
  final _numberEditingController = TextEditingController().obs;
  final _adressEditingController = TextEditingController().obs;
  late File ktp;
  Rx<bool> isPicked = false.obs;
  bool isValid() {
    return _investorNameEditingController.value.text.isNotEmpty &&
        _datePickerController.value.text.isNotEmpty &&
        _emailEditingController.value.text.isNotEmpty &&
        _numberEditingController.value.text.isNotEmpty &&
        _adressEditingController.value.text.isNotEmpty &&
        isPicked.value;
  }

  void printController() {
    String x = '';
    x = _investorNameEditingController.value.text;
    x += '\n $_datePickerController.value.text';
    x += '\n $_emailEditingController.value.text';
    x += '\n $_numberEditingController.value.text';
    x += '\n $_adressEditingController.value.text';
    print(x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: CustomColor.grey,
                height: 1,
              ),
              preferredSize: const Size.fromHeight(3)),
          centerTitle: true,
          title: const Text(
            'Verificate Yourself',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Investor Profile',
                        style: TextStyle(
                            color: CustomColor.lightBlue, fontSize: 20),
                      ),
                      TextField(
                        controller: _investorNameEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Name', hintStyle: Commons.hintStyle),
                      ),
                      TextField(
                        controller: _datePickerController.value,
                        decoration: InputDecoration(
                            hintText: 'DD/MM/YYYY',
                            hintStyle: Commons.hintStyle),
                      ),
                      TextField(
                        controller: _emailEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Email', hintStyle: Commons.hintStyle),
                      ),
                      TextField(
                        controller: _numberEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Number Phone',
                            hintStyle: Commons.hintStyle),
                      ),
                      TextField(
                        controller: _adressEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Adress', hintStyle: Commons.hintStyle),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Required Documents',
                      style:
                          TextStyle(color: CustomColor.lightBlue, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'KTP/SIM',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Obx(
                              () => Icon(
                                Icons.verified,
                                color: isPicked.value
                                    ? Colors.green
                                    : CustomColor.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: Obx(
                            () => Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles(
                                              allowedExtensions: [
                                            'jpg',
                                            'pdf',
                                            'png'
                                          ],
                                              type: FileType.custom);
                                      if (result != null) {
                                        ktp = File(result.files.single.path!);
                                        isPicked.value = true;
                                      }
                                    },
                                    // ignore: sort_child_properties_last
                                    child: const Text(
                                      'Browse',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: Commons.blueButtonStyle),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: isPicked.value
                                        ? () async {
                                            OpenFilex.open(ktp.path);
                                          }
                                        : null,
                                    child: const Text(
                                      'Preview',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: Commons.blueButtonStyle),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                // ignore: sort_child_properties_last
                child: ElevatedButton(
                  onPressed: () async {
                    if (isValid()) {
                      final user = InvestorUser(
                          ktpUrl: ktp.path,
                          uid: firebaseUser.uid,
                          profileImage: firebaseUser.photoURL,
                          name: _investorNameEditingController.value.text,
                          adress: _adressEditingController.value.text,
                          dateTime: _datePickerController.value.text,
                          email: _emailEditingController.value.text,
                          numberPhone: _numberEditingController.value.text);
                      bool isSuccess = await InvestorService().addUser(user);
                      if (isSuccess) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ValidationPendingPage(
                                      isStartup: false,
                                      email: email,
                                      password: password,
                                      text:
                                          'Your application is on review, Please check again after 48 hours.',
                                    )),
                            (route) => false);
                      }
                    } else {
                      print('inputan kurang');
                    }
                  },
                  child: const Text(
                    'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                width: double.infinity,
              ),
            ],
          ),
        ));
  }
}
