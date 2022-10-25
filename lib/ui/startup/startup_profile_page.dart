import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/models/startup_user.dart';
import 'package:fyi/services/startup_service.dart';
import 'package:fyi/ui/startup/update_startup_profile.dart';

class StartupProfilePage extends StatelessWidget {
  String uid;
  StartupProfilePage({super.key, required this.uid});
  late StartupUser startupUser;
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
                              UpdateStartupProfile(user: startupUser)));
                },
                icon: Icon(
                  Icons.edit,
                  color: CustomColor.lightBlue,
                ))
          ],
        ),
        body: StreamBuilder(
            stream: StartupService().getUserStream(uid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = StartupUser.fromJson(snapshot.data!.data()!);
                startupUser = user;
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
                                backgroundImage: NetworkImage(
                                  user.profileImage!,
                                ),
                                radius: 100,
                                backgroundColor: Colors.transparent,
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
                            ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        CustomColor.lightBlue),
                                    shape: MaterialStateProperty.all(
                                        const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))))),
                                child: const Text(
                                  'See ourr Funding Application',
                                  style: TextStyle(color: Colors.white),
                                )),
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
                            'About Us',
                            style: TextStyle(
                                color: CustomColor.lightBlue, fontSize: 25),
                          ),
                          Text(
                            user.description ??
                                'Set your description in update menu',
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
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
