import 'package:flutter/material.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/services/auth_service.dart';
import 'package:fyi/ui/investor/verification_page.dart';
import 'package:fyi/ui/startup/funding_page.dart';
import 'package:fyi/ui/widgets/loading_alert.dart';
import 'package:fyi/ui/widgets/signup_form.dart';
import 'package:fyi/ui/widgets/widget_tree.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final isStartup = false.obs;
  final _nameEditingController = TextEditingController().obs;
  final _emailEditingController = TextEditingController().obs;
  final _passwordEditingController = TextEditingController().obs;
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
                  child: Obx(
                    () => Row(
                      children: [
                        TextButton(
                            onPressed: () => isStartup.value = false,
                            child: Text(
                              'Investor',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: isStartup.value
                                      ? CustomColor.grey
                                      : CustomColor.lightBlue),
                            )),
                        const Text('/'),
                        TextButton(
                            onPressed: () => isStartup.value = true,
                            child: Text(
                              'Startup',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: isStartup.value
                                      ? CustomColor.lightBlue
                                      : CustomColor.grey),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => SignUpForm(
                isStartup: isStartup.value,
                emailEditingController: _emailEditingController,
                passwordEditingController: _passwordEditingController,
                nameEditingController: _nameEditingController,
              ),
            ),
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
                  onPressed: () async {
                    try {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            LoadingAlert(message: "Loading...."),
                      );
                      final user = await AuthService()
                          .createUserWithEmailAndPassword(
                              email: _emailEditingController.value.text,
                              password: _passwordEditingController.value.text);
                      WidgetTree.isStartup = isStartup.value;
                      Navigator.pop(context);
                      if (user != null) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => isStartup.value
                                  ? FundingPage(
                                      firebaseUser: user,
                                      email: _emailEditingController.value.text,
                                      password:
                                          _passwordEditingController.value.text,
                                    )
                                  : VerificationPage(
                                      firebaseUser: user,
                                      password:
                                          _passwordEditingController.value.text,
                                      email: _emailEditingController.value.text,
                                    ),
                            ),
                            (route) => false);
                      } else {
                        print('gagal register');
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
