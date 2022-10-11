import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({super.key});
  final _nameEditingController = TextEditingController().obs;
  final _emailEditingController = TextEditingController().obs;
  final _passwordEditingController = TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
            decoration: const InputDecoration(
                hintText: 'Email', prefixIcon: Icon(Icons.person_outlined)),
            controller: _nameEditingController.value,
          ),
          TextField(
            decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: SvgPicture.asset(
                  'assets/svg/@icon.svg',
                  fit: BoxFit.scaleDown,
                  height: 10,
                  width: 10,
                )),
            controller: _emailEditingController.value,
          ),
          TextField(
            decoration: const InputDecoration(
                hintText: 'Password', prefixIcon: Icon(Icons.lock)),
            controller: _passwordEditingController.value,
          )
        ],
      ),
    );
  }
}
