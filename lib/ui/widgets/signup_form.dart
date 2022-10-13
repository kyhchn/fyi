import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  Rx<TextEditingController> nameEditingController;
  Rx<TextEditingController> emailEditingController;
  Rx<TextEditingController> passwordEditingController;
  bool isStartup;
  SignUpForm(
      {super.key,
      required this.emailEditingController,
      required this.nameEditingController,
      required this.passwordEditingController,
      required this.isStartup});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: isStartup ? 'Startup Name' : 'Your name / Company',
                  prefixIcon: const Icon(Icons.person_outlined)),
              controller: nameEditingController.value,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: SvgPicture.asset(
                    'assets/svg/@icon.svg',
                    fit: BoxFit.scaleDown,
                    height: 10,
                    width: 10,
                  )),
              controller: emailEditingController.value,
            ),
            TextField(
              decoration: const InputDecoration(
                  hintText: 'Password', prefixIcon: Icon(Icons.lock)),
              controller: passwordEditingController.value,
            )
          ],
        ),
      ),
    );
  }
}
