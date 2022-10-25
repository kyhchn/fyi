import 'package:flutter/material.dart';
import 'package:fyi/commons.dart';
import 'package:fyi/ui/widgets/widget_tree.dart';

class ValidationPendingPage extends StatelessWidget {
  String text;
  bool isStartup;
  ValidationPendingPage(
      {super.key, required this.text, required this.isStartup});
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
                onPressed: () {
                  WidgetTree.isStartup = isStartup;
                  // final data = await AuthService().signInWithEmailAndPassword(
                  //     email: email, password: password);
                  // if (data != null) {
                  //   // ignore: use_build_context_synchronously
                  //   Navigator.pushAndRemoveUntil(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => HomePage(
                  //           isStartup: isStartup,
                  //           user: data,
                  //         ),
                  //       ),
                  //       (route) => false);
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('gagal login')));
                  // }
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => WidgetTree()),
                      (route) => false);
                },
                // ignore: sort_child_properties_last
                child: const Text(
                  'Go To Login Page',
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
