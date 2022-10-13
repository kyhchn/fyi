import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/ui/general/home_page.dart';

class ValidationPendingPage extends StatelessWidget {
  String text;
  ValidationPendingPage({super.key, required this.text});
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
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false),
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
