import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/ui/widgets/file_picker_widget.dart';
import 'package:fyi/ui/general/validation_pending_page.dart';
import 'package:get/get.dart';

class FundingPage extends StatelessWidget {
  FundingPage({super.key});
  final _startupNameEditingController = TextEditingController().obs;
  final _emailEditingController = TextEditingController().obs;
  final _numberEditingController = TextEditingController().obs;
  final _adressEditingController = TextEditingController().obs;
  final _startupCategoryNameEditingController = TextEditingController().obs;
  final _websiteNameEditingController = TextEditingController().obs;
  final _totalFundsEditingController = TextEditingController().obs;
  final _dividendDistEditingController = TextEditingController().obs;
  final mapFilePickerWidget = <String, FilePickerWidget>{
    'Company Profile': FilePickerWidget(
      nameFile: 'Company Profile',
    ),
    'Business Plan': FilePickerWidget(
      nameFile: 'Business Plan',
    ),
    'Funding Proposal': FilePickerWidget(
      nameFile: 'Funding Proposal',
    ),
    'Cash Flow (Optional)': FilePickerWidget(
      nameFile: 'Cash Flow (Optional)',
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
        _websiteNameEditingController.value.text.isNotEmpty &&
        _totalFundsEditingController.value.text.isNotEmpty &&
        _dividendDistEditingController.value.text.isNotEmpty &&
        mapIsValid();
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
          'Apply for Funding',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        controller: _websiteNameEditingController.value,
                        decoration: InputDecoration(
                            hintText: 'Website / Social Media',
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
              child: ElevatedButton(
                onPressed: () {
                  if (isValid()) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ValidationPendingPage(
                                password: 'asdasd',
                                email: 'aadasd',
                                isStartup: true,
                                text:
                                    'Your application is on review, Please check again after 48 hours to pitching with our teams.')),
                        (route) => false);
                    return;
                  }
                  print('jancok ono seng kurang tod');
                },
                child: Text(
                  'Apply',
                  style: TextStyle(color: Colors.white),
                ),
                style: Commons.blueButtonStyle,
              ),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
