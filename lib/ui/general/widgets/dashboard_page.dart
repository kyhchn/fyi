import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/services/auth_service.dart';
import 'package:fyi/ui/general/notification_page.dart';
import 'package:fyi/ui/general/widgets/catalog_card.dart';
import 'package:fyi/ui/investor/investor_profile_page.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  bool isVerified = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 0, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.1,
            width: size.width - 40,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InvestorProfilePage(),
                      )),
                  child: SizedBox(
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/svg/defaultAvatarIcon.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Name',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              isVerified ? 'Verified' : 'Unverified',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: isVerified
                                      ? CustomColor.lightBlue
                                      : CustomColor.grey),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: SvgPicture.asset('assets/svg/newNotificationIcon.svg'),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NotificationPage(),
                  )),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right_alt_outlined),
                  onPressed: () => AuthService().signOut(),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SizedBox(
            height: size.height * 0.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recently Added',
                  style: TextStyle(color: CustomColor.lightBlue),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => CatalogCard(size: size),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                    // children: [
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    // ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SizedBox(
            height: size.height * 0.28,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Most Popular',
                  style: TextStyle(color: CustomColor.lightBlue),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => CatalogCard(size: size),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 20,
                    ),
                    // children: [
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    //   CatalogCard(size: size),
                    // ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
