import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fyi/ui/widgets/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Aoboshi-One',
          primarySwatch: Colors.lightBlue,
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: WidgetTree(),
    );
  }
}
