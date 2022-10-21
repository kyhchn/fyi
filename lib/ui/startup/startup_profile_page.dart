import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';

class StartupProfilePage extends StatelessWidget {
  const StartupProfilePage({super.key});

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
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset('assets/svg/Avatar.svg'),
                  ),
                  Text(
                    'Startup Name',
                    style:
                        TextStyle(color: CustomColor.lightBlue, fontSize: 25),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
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
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text(
                    'About Us',
                    style:
                        TextStyle(color: CustomColor.lightBlue, fontSize: 25),
                  ),
                  Text(
                    Commons.longLorem,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: CustomColor.grey),
                  )
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      iconSize: 50,
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/svg/linkedinIcon.svg')),
                  IconButton(
                      iconSize: 50,
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/svg/twitterIcon.svg')),
                  IconButton(
                      iconSize: 50,
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/svg/instagramIcon.svg'))
                ],
              )
            ],
          ),
        ));
  }
}
