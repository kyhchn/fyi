import 'package:flutter/material.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Transaction History',
                style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
              ),
            ],
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
                      leading: const Icon(
                        Icons.person,
                        size: 40,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Holy cow',
                            style: TextStyle(color: CustomColor.lightBlue),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 1),
                            child: const Text('asas'),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                          )
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          const Text(
                              'This is the pitch deck schedule and link video conference, please come on time'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all(Size.zero),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              CustomColor.lightBlue),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 1)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14))))),
                                  onPressed: () {},
                                  child: const Text('Invest')),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                      minimumSize:
                                          MaterialStateProperty.all(Size.zero),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              CustomColor.grey),
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 1)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(14))))),
                                  onPressed: () {},
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                          )
                        ],
                      ),
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
