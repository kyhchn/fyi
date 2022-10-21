import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/models/startup_user.dart';
import 'package:fyi/services/auth_service.dart';
import 'package:fyi/ui/general/home_page.dart';
import 'package:fyi/ui/widgets/widget_tree.dart';

class ValidationPendingPage extends StatelessWidget {
  String text, email, password;
  bool isStartup;
  ValidationPendingPage(
      {super.key,
      required this.text,
      required this.password,
      required this.email,
      required this.isStartup});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/watchIcon.png'),
            const SizedBox(
              height: 20,
            ),
            Text(
              text,
              style: const TextStyle(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  WidgetTree.isStartup = isStartup;
                  await AuthService().signInWithEmailAndPassword(
                      email: email, password: password);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                      (route) => false);
                },
                child: const Text(
                  'Go To Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                style: Commons.blueButtonStyle,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
