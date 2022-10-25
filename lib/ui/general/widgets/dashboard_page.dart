import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/funding.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/models/startup_user.dart';
import 'package:fyi/services/auth_service.dart';
import 'package:fyi/services/funding_service.dart';
import 'package:fyi/ui/general/notification_page.dart';
import 'package:fyi/ui/general/widgets/catalog_card.dart';
import 'package:fyi/ui/investor/investor_profile_page.dart';
import 'package:fyi/ui/startup/startup_profile_page.dart';

class DashBoard extends StatelessWidget {
  DocumentReference<Map<String, dynamic>> userRef;
  InvestorUser? investorUser;
  StartupUser? startupUser;
  bool isStartup;
  DashBoard(
      {super.key,
      this.investorUser,
      required this.userRef,
      this.startupUser,
      required this.isStartup});
  String? getImagePath() {
    return isStartup ? startupUser!.profileImage : investorUser!.profileImage;
  }

  bool isVerified() {
    return isStartup ? startupUser!.isVerified : investorUser!.isVerified;
  }

  String getName() {
    return isStartup ? startupUser!.name : investorUser!.name;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 0, 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder(
              stream: userRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (isStartup) {
                    startupUser = StartupUser.fromJson(snapshot.data!.data()!);
                  } else {
                    investorUser =
                        InvestorUser.fromJson(snapshot.data!.data()!);
                  }
                  return Container(
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
                                builder: (context) => isStartup
                                    ? StartupProfilePage(
                                        uid: startupUser!.uid,
                                      )
                                    : InvestorProfilePage(
                                        uid: investorUser!.uid,
                                      ),
                              )),
                          child: SizedBox(
                            child: Row(
                              children: [
                                Builder(builder: (context) {
                                  if (getImagePath() == null) {
                                    return SvgPicture.asset(
                                        'assets/svg/defaultAvatarIcon.svg');
                                  } else {
                                    return CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          NetworkImage(getImagePath()!),
                                    );
                                  }
                                }),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getName(),
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    Text(
                                      isVerified() ? 'Verified' : 'Unverified',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: isVerified()
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
                          icon: SvgPicture.asset(
                              'assets/svg/newNotificationIcon.svg'),
                          onPressed: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          )),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right_alt_outlined),
                          onPressed: () => AuthService().signOut(),
                        )
                      ],
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
          SizedBox(
            height: size.height * 0.05,
          ),
          StreamBuilder(
              stream: FundingService().getNormalfundingStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Funding> data = [];
                  for (var element in snapshot.data!.docs) {
                    data.add(Funding.fromJson(element.data()));
                  }
                  return Column(
                    children: [
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
                                itemCount: data.length,
                                itemBuilder: (context, index) => CatalogCard(
                                  size: size,
                                  isStartup: isStartup,
                                  funding: data[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 20,
                                ),
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
                                itemCount: data.length,
                                itemBuilder: (context, index) => CatalogCard(
                                  size: size,
                                  isStartup: isStartup,
                                  funding: data[index],
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(
                                  width: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
