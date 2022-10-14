import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';

class StartupDetailPage extends StatelessWidget {
  bool isStartup;
  File? startupProfile, fundingProposal, businessPlan;
  File? cashFlow;
  StartupDetailPage(
      {super.key,
      required this.isStartup,
      this.startupProfile,
      this.businessPlan,
      this.fundingProposal,
      this.cashFlow});
  DateTime? datePicked;
  TimeOfDay? timePicked;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17)),
                    color: CustomColor.darkerLightGrey),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Startup Name',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Short Description',
                      style:
                          TextStyle(color: CustomColor.lightBlue, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      Commons.lorem,
                      style: TextStyle(color: CustomColor.grey),
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'More Information',
                        style: TextStyle(
                            color: CustomColor.lightBlue, fontSize: 22),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: [
                            const DocumentButton(),
                            const DocumentButton(),
                            const DocumentButton(),
                            const DocumentButton()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              isStartup
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              iconSize: 45,
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                'assets/svg/messageIcon.svg',
                                color: CustomColor.lightBlue,
                                height: 45,
                                width: 45,
                              )),
                          ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)))),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10))),
                              onPressed: () async {
                                final datePicked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now()
                                        .add(const Duration(days: 1)),
                                    firstDate: DateTime.now()
                                        .add(const Duration(days: 1)),
                                    lastDate: DateTime(2023));
                                final timePicked = await showTimePicker(
                                    context: context,
                                    initialTime:
                                        const TimeOfDay(hour: 0, minute: 0));
                                if (datePicked != null)
                                  this.datePicked = datePicked;
                                if (timePicked != null)
                                  this.timePicked = timePicked;
                                if (datePicked != null && timePicked != null) {
                                  showModalBottomSheet(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(15))),
                                      context: context,
                                      builder: (context) => Container(
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15))),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            height: size.height * 0.2,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Your pitch deck will be held on ${datePicked.toString()} at ${timePicked.toString()} are you sure',
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15))),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(CustomColor
                                                                        .lightBlue)),
                                                        onPressed: () {},
                                                        child: const Text(
                                                            'Reschedule')),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    ElevatedButton(
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15))),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(CustomColor
                                                                        .lightBlue)),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                            'Pitch Deck'))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ));
                                }
                              },
                              child: const Text(
                                'Schedule Pitch Deck',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ))
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    )
            ],
          ),
          const Icon(Icons.arrow_back),
        ],
      )),
    );
  }
}

class DocumentButton extends StatelessWidget {
  const DocumentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/pdfIcon.svg',
            color: CustomColor.grey,
          ),
          Text(
            'apalah ini yaaa',
            style: TextStyle(color: CustomColor.grey),
          )
        ],
      ),
    );
  }
}
