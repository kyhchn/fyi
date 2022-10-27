import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyi/models/startup_user.dart';

class StartupService {
  final firestore = FirebaseFirestore.instance.collection('startup');
  User? user;
  StartupService({this.user});

  Future<bool> addUser(StartupUser user) async {
    try {
      await firestore.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<void> updateUser(StartupUser user) async {
    await firestore.doc(user.uid).update(user.toJson());
  }

  Future<StartupUser?> getUser(String uid) async {
    StartupUser? ret;
    final data = await firestore.doc(uid).get().then((value) {
      if (value.exists) {
        ret = StartupUser.fromJson(value.data()!);
      } else {
        ret = null;
      }
    });
    return ret;
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String uid) {
    return firestore.doc(uid).snapshots();
  }

  DocumentReference<Map<String, dynamic>> getUserReference(String uid) {
    return firestore.doc(uid);
  }
}
