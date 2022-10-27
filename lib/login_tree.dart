import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ui/general/home_page.dart';

class LoginTree extends StatefulWidget {
  User user;
  LoginTree({super.key, required this.user, required this.isStartup});
  bool isStartup;
  @override
  State<LoginTree> createState() => _LoginTreeState();
}

class _LoginTreeState extends State<LoginTree> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('startup')
            .doc(widget.user.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return HomePage(
                isStartup: true,
                user: widget.user,
              );
            } else {
              return HomePage(
                isStartup: false,
                user: widget.user,
              );
            }
          }
          return Container(
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
