import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fyi/custom_color.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15), right: Radius.circular(15))),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          'Notification',
          style: TextStyle(color: CustomColor.lightBlue, fontSize: 25),
        ),
      ),
      body: Padding(
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
    );
  }
}
// BoxShadow(
//                         color: Colors.grey.withOpacity(0.3),
//                         blurStyle: BlurStyle.inner,
//                         spreadRadius: 2,
//                         blurRadius: 5,
//                         offset: Offset(0, 3), // changes position of shadow
//                       ),
