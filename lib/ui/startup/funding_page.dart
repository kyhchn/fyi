import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/funding.dart';
import 'package:fyi/models/startup_user.dart';
import 'package:fyi/services/funding_service.dart';
import 'package:fyi/services/startup_service.dart';
import 'package:fyi/services/cloud_storage_service.dart';
import 'package:fyi/ui/widgets/file_picker_widget.dart';
import 'package:fyi/ui/general/validation_pending_page.dart';
import 'package:fyi/ui/widgets/loading_alert.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

class FundingPage extends StatelessWidget {
  User firebaseUser;
  String email, password;
  FundingPage(
      {super.key,
      required this.firebaseUser,
      required this.email,
      required this.password});
  final _startupNameEditingController = TextEditingController().obs;
  final _emailEditingController = TextEditingController().obs;
  final _numberEditingController = TextEditingController().obs;
  final _adressEditingController = TextEditingController().obs;
  final _startupCategoryNameEditingController = TextEditingController().obs;
  final _totalFundsEditingController = TextEditingController().obs;
  final _dividendDistEditingController = TextEditingController().obs;
  final _shortDescriptionEditingController = TextEditingController().obs;
  late File fundingImage;
  final fundingImageIsPicked = false.obs;
  final mapFilePickerWidget = <String, FilePickerWidget>{
    'Company Profile': FilePickerWidget(
      nameFile: 'Company Profile',
      examplePath: 'assets/documents/bussinessProfile.pdf',
    ),
    'Business Plan': FilePickerWidget(
      nameFile: 'Business Plan',
      examplePath: 'assets/documents/bussinessPlan.pdf',
    ),
    'Funding Proposal': FilePickerWidget(
      nameFile: 'Funding Proposal',
      examplePath: 'assets/documents/fundingfProposal.pdf',
    ),
    'Cash Flow (Optional)': FilePickerWidget(
      nameFile: 'Cash Flow (Optional)',
      examplePath: 'assets/documents/cashFlow.pdf',
    )
  };
  bool mapIsValid() {
    return mapFilePickerWidget['Company Profile']!.file != null &&
        mapFilePickerWidget['Business Plan']!.file != null &&
        mapFilePickerWidget['Funding Proposal']!.file != null;
  }

  bool isValid() {
    return _startupNameEditingController.value.text.isNotEmpty &&
        _emailEditingController.value.text.isNotEmpty &&
        _numberEditingController.value.text.isNotEmpty &&
        _adressEditingController.value.text.isNotEmpty &&
        _startupCategoryNameEditingController.value.text.isNotEmpty &&
        _totalFundsEditingController.value.text.isNotEmpty &&
        _dividendDistEditingController.value.text.isNotEmpty &&
        _shortDescriptionEditingController.value.text.isNotEmpty &&
        mapIsValid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(3),
            child: Container(
              color: CustomColor.grey,
              height: 1,
            )),
        centerTitle: true,
        title: const Text(
          'Apply for Funding',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 2),
        child: Column(
          children: [
            SizedBox(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company Profile',
                      style:
                          TextStyle(color: CustomColor.lightBlue, fontSize: 20),
                    ),
                    TextField(
                      controller: _startupNameEditingController.value,
                      decoration: InputDecoration(
                          hintText: 'Startup Name',
                          hintStyle: Commons.hintStyle),
                    ),
                    TextField(
                        controller: _emailEditingController.value,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: 'Email', hintStyle: Commons.hintStyle)),
                    TextField(
                        controller: _numberEditingController.value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText: 'Number Phone / FAQ',
                            hintStyle: Commons.hintStyle)),
                    TextField(
                        controller: _adressEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Adress', hintStyle: Commons.hintStyle)),
                    TextField(
                        controller: _startupCategoryNameEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Startup Category',
                            hintStyle: Commons.hintStyle)),
                    TextField(
                        controller: _shortDescriptionEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Short Description',
                            hintStyle: Commons.hintStyle))
                  ],
                ),
              ),
            ),
            Obx(
              () => SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Funding Proposal',
                        style: TextStyle(
                            color: CustomColor.lightBlue, fontSize: 20)),
                    TextField(
                        autofocus: true,
                        controller: _totalFundsEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Total funds (\$ USD)',
                            hintStyle: Commons.hintStyle)),
                    TextField(
                        controller: _dividendDistEditingController.value,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            hintText:
                                'Dividend distribution frequency per year',
                            hintStyle: Commons.hintStyle)),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Funding Image',
                              style: TextStyle(color: CustomColor.grey),
                            ),
                            Icon(
                              Icons.verified,
                              color: fundingImageIsPicked.value
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
                                    FilePickerResult? result = await FilePicker
                                        .platform
                                        .pickFiles(allowedExtensions: [
                                      'png',
                                      'jpg',
                                      'jpeg'
                                    ], type: FileType.custom);
                                    if (result != null) {
                                      fundingImage =
                                          File(result.files.single.path!);
                                      fundingImageIsPicked.value = true;
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
                                  onPressed: fundingImageIsPicked.value
                                      ? () async {
                                          OpenFilex.open(fundingImage.path);
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
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Required Documents',
                      style: TextStyle(
                          color: CustomColor.lightBlue, fontSize: 20)),
                  mapFilePickerWidget['Company Profile']!,
                  const SizedBox(
                    height: 2,
                  ),
                  mapFilePickerWidget['Business Plan']!,
                  const SizedBox(
                    height: 2,
                  ),
                  mapFilePickerWidget['Funding Proposal']!,
                  const SizedBox(
                    height: 2,
                  ),
                  mapFilePickerWidget['Cash Flow (Optional)']!,
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (isValid()) {
                    showDialog(
                      context: context,
                      builder: (context) => LoadingAlert(message: "Uploading"),
                    );
                    final companyProfile =
                        mapFilePickerWidget['Company Profile']!.file!;
                    final businessPlan =
                        mapFilePickerWidget['Business Plan']!.file!;
                    final fundingProposal =
                        mapFilePickerWidget['Funding Proposal']!.file!;
                    final cashFlow =
                        mapFilePickerWidget['Cash Flow (Optional)']!.file;
                    final companyProfileUpload =
                        await CloudStorageService(file: companyProfile)
                            .uploadFile(
                                "users/startup/${firebaseUser.uid}/documents");
                    final businessPlanUpload =
                        await CloudStorageService(file: businessPlan)
                            .uploadFile(
                                "users/startup/${firebaseUser.uid}/documents");
                    final fundingProposalUpload =
                        await CloudStorageService(file: fundingProposal)
                            .uploadFile(
                                "users/startup/${firebaseUser.uid}/documents");
                    final cashFlowUpload = (cashFlow == null)
                        ? null
                        : await CloudStorageService(file: cashFlow).uploadFile(
                            "users/startup/${firebaseUser.uid}/documents");
                    final fundingImageUpload =
                        await CloudStorageService(file: fundingImage)
                            .uploadImage(
                                "users/startup/${firebaseUser.uid}/documents");
                    final funding = Funding(
                        imageUrl: fundingImageUpload!,
                        shortDescription:
                            _shortDescriptionEditingController.value.text,
                        startupName: _startupNameEditingController.value.text,
                        dividend: _dividendDistEditingController.value.text,
                        startupCategory:
                            _startupCategoryNameEditingController.value.text,
                        bussinessPlanUrl: businessPlanUpload!,
                        companyProfileUrl: companyProfileUpload!,
                        fundingProposalUrl: fundingProposalUpload!,
                        cashFlowUrl: cashFlowUpload,
                        startupUid: firebaseUser.uid,
                        totalFunds: _totalFundsEditingController.value.text);

                    final user = StartupUser(
                        isVerified: false,
                        uid: firebaseUser.uid,
                        profileImage: firebaseUser.photoURL,
                        name: _startupNameEditingController.value.text,
                        adress: _adressEditingController.value.text,
                        email: email,
                        numberPhone: _numberEditingController.value.text);
                    final isSuccessAddUser =
                        await StartupService().addUser(user);
                    final isSuccessAddFunding =
                        await FundingService().addFunding(funding);
                    Navigator.pop(context);
                    if (isSuccessAddFunding && isSuccessAddUser) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ValidationPendingPage(
                                  isStartup: true,
                                  text:
                                      'Your application is on review, Please check again after 48 hours to pitching with our teams.')),
                          (route) => false);
                    } else {
                      print('add user gagal');
                    }
                  }
                },
                style: Commons.blueButtonStyle,
                child: const Text(
                  'Apply',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
