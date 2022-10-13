import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/ui/general/widgets/catalogue_page.dart';
import 'package:fyi/ui/general/widgets/dashboard_page.dart';
import 'package:fyi/ui/general/widgets/message_page.dart';
import 'package:fyi/ui/general/widgets/transaction_page.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var _index = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          () => SafeArea(
            child: _index.value == 0
                ? DashBoard()
                : _index.value == 1
                    ? CataloguePage()
                    : _index.value == 2
                        ? MessagePage()
                        : TransactionPage(),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Obx(
          () => CustomNavigationBar(
            bubbleCurve: Curves.easeIn,
            iconSize: 30,
            backgroundColor: CustomColor.lightBlue,
            items: [
              CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/homeIcon.svg',
                  color:
                      _index.value == 0 ? Colors.blue.shade700 : Colors.white,
                ),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/catalogIcon.svg',
                  color:
                      _index.value == 1 ? Colors.blue.shade700 : Colors.white,
                ),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/messageIcon.svg',
                  color:
                      _index.value == 2 ? Colors.blue.shade700 : Colors.white,
                ),
              ),
              CustomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/transactionIcon.svg',
                  color:
                      _index.value == 3 ? Colors.blue.shade700 : Colors.white,
                ),
              ),
            ],
            currentIndex: _index.value,
            onTap: (index) => _index.value = index,
          ),
        ));
  }
}
