import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/ui/general/startup_detail_page.dart';

class CatalogCard extends StatelessWidget {
  Size size;
  CatalogCard({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StartupDetailPage(
          isStartup: true,
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
                color: CustomColor.lightBlue,
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
                  const Text('Startup Name'),
                  Text(
                    '\$1k',
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
