import 'package:flutter/cupertino.dart';
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
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}
