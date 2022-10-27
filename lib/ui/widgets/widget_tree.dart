import 'package:flutter/material.dart';
import 'package:fyi/login_tree.dart';
import 'package:fyi/services/auth_service.dart';
import 'package:fyi/ui/general/home_page.dart';
import 'package:fyi/ui/general/login_page.dart';

class WidgetTree extends StatefulWidget {
  WidgetTree({super.key});
  static bool isStartup = false;
  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(
              isStartup: WidgetTree.isStartup, user: snapshot.data!);
        }
        return LoginPage();
      },
    );
  }

  // Future<void> selectorUser(User user) async {
  //   if (WidgetTree.isStartup) {
  //     StartupUser? startupUser = await StartupService().getUser(user.uid);
  //     this.startupUser = startupUser;
  //   } else {
  //     InvestorUser? investorUser = await InvestorService().getUser(user.uid);
  //     this.investorUser = investorUser;
  //   }
  // }
}
