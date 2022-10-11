import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fyi/custom_color.dart';
import 'package:fyi/ui/general/signup_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _emailEditingController = TextEditingController().obs;
  final _passwordEditingController = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/loginIcon.png',
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        hintText: 'Email', prefixIcon: Icon(Icons.email)),
                    controller: _emailEditingController.value,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        hintText: 'Password', prefixIcon: Icon(Icons.lock)),
                    controller: _passwordEditingController.value,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot password ? ',
                      style: TextStyle(color: Colors.lightBlue),
                    ))
              ],
            ),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: () {},
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 2,
                  color: CustomColor.grey,
                ),
                const Text('OR'),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 3,
                  color: CustomColor.grey,
                )
              ],
            ),
            SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                            CustomColor.grey.withOpacity(0.2)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            'assets/svg/flat-color-icons_google.svg'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Text(
                          'Login With Google',
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ],
                    ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('New to FYI ?'),
                TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage())),
                    child: const Text('\tRegister'))
              ],
            )
          ],
        ),
      )),
    );
  }
}
