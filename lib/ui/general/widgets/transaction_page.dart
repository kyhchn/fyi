import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyi/custom_color.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          width: double.infinity,
          height: size.height * 0.1,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Text(
            'Transaction History',
            style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      iconColor: CustomColor.lightBlue,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      tileColor: CustomColor.lighterLightBlue.withOpacity(0.2),
                      leading: const Icon(Icons.arrow_back),
                      title: Text(
                        'Let\'s pith deck with our team',
                        style: TextStyle(color: CustomColor.lightBlue),
                      ),
                      subtitle: const Text(
                          'This is the pitch deck schedule and link video conference, please come on time'),
                    ),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 15,
                    ),
                itemCount: 10),
          ),
        ),
      ],
    );
  }
}
