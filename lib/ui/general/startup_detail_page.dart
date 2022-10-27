import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/funding.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/services/cloud_storage_service.dart';
import 'package:fyi/services/investor_service.dart';
import 'package:fyi/services/transaction_service.dart';
import 'package:fyi/ui/widgets/loading_alert.dart';
import 'package:open_filex/open_filex.dart';

class StartupDetailPage extends StatelessWidget {
  bool isStartup;
  Funding funding;
  User user;
  StartupDetailPage(
      {super.key,
      required this.isStartup,
      required this.funding,
      required this.user});
  DateTime? datePicked;
  TimeOfDay? timePicked;
  String getDate(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
  }

  String getTime(TimeOfDay time) {
    return "${time.hour}:${time.minute}";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(funding.imageUrl), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(17),
                      bottomRight: Radius.circular(17)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    funding.startupName,
                    style: const TextStyle(fontSize: 25),
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
                      funding.shortDescription,
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
                            DocumentButton(
                              documentPath: funding.bussinessPlanUrl,
                              text: 'Bussiness Plan',
                            ),
                            DocumentButton(
                              documentPath: funding.companyProfileUrl,
                              text: 'Company Profile',
                            ),
                            DocumentButton(
                                documentPath: funding.fundingProposalUrl,
                                text: 'Funding Proposal'),
                            Builder(builder: (context) {
                              if (funding.cashFlowUrl != null) {
                                return DocumentButton(
                                  documentPath: funding.cashFlowUrl!,
                                  text: 'Cash Flow',
                                );
                              }
                              return const SizedBox(
                                height: 0,
                                width: 0,
                              );
                            })
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              !isStartup
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
                                                  'Your pitch deck will be held on ${getDate(datePicked)} at ${getTime(timePicked)} are you sure??',
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
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
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
                                                        onPressed: () async {
                                                          showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                LoadingAlert(
                                                                    message:
                                                                        'Loading...'),
                                                          );
                                                          InvestorUser?
                                                              investorUser =
                                                              await InvestorService()
                                                                  .getUser(
                                                                      user.uid);
                                                          await TransactionService()
                                                              .addTransaction(
                                                                  datePicked,
                                                                  timePicked,
                                                                  funding
                                                                      .startupName,
                                                                  funding
                                                                      .startupUid,
                                                                  investorUser!);
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
          IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ))
        ],
      )),
    );
  }
}

class DocumentButton extends StatelessWidget {
  String documentPath;
  String text;
  DocumentButton({Key? key, required this.documentPath, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) => LoadingAlert(message: "Please wait..."),
        );
        File? result = await CloudStorageService().downloadFile(documentPath);
        Navigator.pop(context);
        await OpenFilex.open(result!.path);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/pdfIcon.svg',
            color: CustomColor.grey,
          ),
          Text(
            text,
            style: TextStyle(color: CustomColor.grey),
          )
        ],
      ),
    );
  }
}
