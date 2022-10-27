import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/funding.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/ui/general/startup_detail_page.dart';

class CatalogCard extends StatelessWidget {
  User user;
  Size size;
  bool isStartup;
  Funding funding;
  InvestorUser? investorUser;
  CatalogCard(
      {super.key,
      required this.size,
      required this.isStartup,
      required this.user,
      this.investorUser,
      required this.funding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StartupDetailPage(
          user: user,
          isStartup: isStartup,
          funding: funding,
        ),
      )),
      child: Card(
        elevation: 4.5,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.38,
              height: size.height * 0.13,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(funding.imageUrl), fit: BoxFit.cover),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(funding.startupName),
                  Text(
                    '\$${funding.totalFunds}',
                    style: TextStyle(color: CustomColor.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
