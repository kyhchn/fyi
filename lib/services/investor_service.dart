import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyi/models/investor_user.dart';

class InvestorService {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');
  User? user;
  InvestorService({this.user});

  Future<bool> addUser(InvestorUser user) async {
    try {
      await firestore.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  InvestorUser? getUser(String uid) {
    firestore.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return InvestorUser.fromJson(
            jsonDecode(documentSnapshot.data().toString()));
      }
    });
    return null;
  }
}
