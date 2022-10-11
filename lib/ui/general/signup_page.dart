import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/ui/startup/funding_page.dart';
import 'package:fyi/ui/widgets/signup_form.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  final isStartup = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/loginIcon.png',
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Investor',
                            style: TextStyle(
                                fontSize: 15,
                                color: isStartup
                                    ? CustomColor.grey
                                    : CustomColor.lightBlue),
                          )),
                      const Text('/'),
                      Obx(
                        () => TextButton(
                            onPressed: () {},
                            child: Text(
                              'Startup',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: isStartup
                                      ? CustomColor.lightBlue
                                      : CustomColor.grey),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
            SignUpForm(),
            RichText(
                text: TextSpan(
                    text: 'By Sign Up , you\'re agree with our ',
                    style: TextStyle(
                        color: CustomColor.grey,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                  TextSpan(
                      text: 'Terms & Conditions ',
                      style: TextStyle(color: CustomColor.lightBlue)),
                  TextSpan(
                      text: 'and ', style: TextStyle(color: CustomColor.grey)),
                  TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: CustomColor.lightBlue)),
                ])),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => FundingPage()),
                        (route) => false),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      )),
    );
  }
}
