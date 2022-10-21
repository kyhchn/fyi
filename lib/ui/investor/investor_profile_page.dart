import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/custom_color.dart';

class InvestorProfilePage extends StatelessWidget {
  const InvestorProfilePage({super.key});
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
                      '\$ sak juta ewu ewu',
                      style: TextStyle(fontSize: 20, color: CustomColor.grey),
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
              const Spacer(),
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
