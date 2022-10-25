import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/services/investor_service.dart';

import 'investor_update_profile.dart';

class InvestorProfilePage extends StatelessWidget {
  String uid;
  InvestorProfilePage({super.key, required this.uid});
  late InvestorUser user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(15), right: Radius.circular(15))),
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            'Profile',
            style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateInvestorProfile(investorUser: user)));
                },
                icon: Icon(
                  Icons.edit,
                  color: CustomColor.lightBlue,
                ))
          ],
        ),
        body: StreamBuilder(
            stream: InvestorService().getUserStream(uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                user = InvestorUser.fromJson(snapshot.data!.data()!);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            if (user.profileImage == null) {
                              return Center(
                                child:
                                    SvgPicture.asset('assets/svg/Avatar.svg'),
                              );
                            } else {
                              return CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 100,
                                backgroundImage:
                                    NetworkImage(user.profileImage!),
                              );
                            }
                          }),
                          Text(
                            user.name,
                            style: TextStyle(
                                color: CustomColor.lightBlue, fontSize: 25),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1,
                              color: CustomColor.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/icons/coinMoneyIcon.png',
                                ),
                                const Text(
                                  'Total Investment',
                                  style: TextStyle(fontSize: 20),
                                )
                              ],
                            ),
                            Text(
                              '\$ ${user.totalInvestment ?? 0}',
                              style: TextStyle(
                                  fontSize: 20, color: CustomColor.grey),
                            ),
                            Container(
                              height: 1,
                              color: CustomColor.grey,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            'About Me',
                            style: TextStyle(
                                color: CustomColor.lightBlue, fontSize: 25),
                          ),
                          Text(
                            user.description ??
                                'fill your description in edit page',
                            textAlign: TextAlign.justify,
                            style: TextStyle(color: CustomColor.grey),
                          )
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Builder(builder: (context) {
                            return user.linkedinLink != null
                                ? IconButton(
                                    iconSize: 50,
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/svg/linkedinIcon.svg'))
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                          }),
                          Builder(builder: (context) {
                            return user.twitterLink != null
                                ? IconButton(
                                    iconSize: 50,
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/svg/twitterIcon.svg'))
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                          }),
                          Builder(builder: (context) {
                            return user.instagramLink != null
                                ? IconButton(
                                    iconSize: 50,
                                    onPressed: () {},
                                    icon: SvgPicture.asset(
                                        'assets/svg/instagramIcon.svg'))
                                : const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                          })
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
