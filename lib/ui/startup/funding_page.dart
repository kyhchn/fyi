import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/ui/widgets/file_picker_widget.dart';

class FundingPage extends StatelessWidget {
  FundingPage({super.key});
  final _startupNameEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _numberEditingController = TextEditingController();
  final _adressEditingController = TextEditingController();
  final _startupCategoryNameEditingController = TextEditingController();
  final _websiteNameEditingController = TextEditingController();

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Startup Profile',
                    style:
                        TextStyle(color: CustomColor.lightBlue, fontSize: 20),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Startup Name', hintStyle: Commons.hintStyle),
                  ),
                  TextField(
                      decoration: InputDecoration(
                          hintText: 'Email', hintStyle: Commons.hintStyle)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: 'Number Phone / FAQ',
                          hintStyle: Commons.hintStyle)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: 'Adress', hintStyle: Commons.hintStyle)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: 'Startup Category',
                          hintStyle: Commons.hintStyle)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: 'Website / Social Media',
                          hintStyle: Commons.hintStyle))
                ],
              ),
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Funding Request',
                      style: TextStyle(
                          color: CustomColor.lightBlue, fontSize: 20)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: 'Total funds (\$ USD)',
                          hintStyle: Commons.hintStyle)),
                  TextField(
                      decoration: InputDecoration(
                          hintText: 'Dividend distribution frequency per year',
                          hintStyle: Commons.hintStyle)),
                ],
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
                  FilePickerWidget(nameFile: 'Company Profile'),
                  const SizedBox(
                    height: 2,
                  ),
                  FilePickerWidget(nameFile: 'Business Plan'),
                  const SizedBox(
                    height: 2,
                  ),
                  FilePickerWidget(nameFile: 'Funding Proposal'),
                  const SizedBox(
                    height: 2,
                  ),
                  FilePickerWidget(nameFile: 'Cash Flow (optional)')
                ],
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Apply',
                  style: TextStyle(color: Colors.white),
                ),
                style: Commons.blueButtonStyle,
              ),
              width: double.infinity,
            )
          ],
        ),
      ),
    );
  }
}
