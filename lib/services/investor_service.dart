import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/services/cloud_storage_service.dart';

class InvestorService {
  static CollectionReference<Map<String, dynamic>> firestore =
      FirebaseFirestore.instance.collection('investor');
  User? user;
  InvestorService({this.user});

  Future<bool> addUser(InvestorUser user, bool isStartup) async {
    try {
      await firestore.doc(user.uid).set(user.toJson());
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<InvestorUser?> getUser(String uid) async {
    await firestore.doc(uid).get().then((value) {
      if (value.exists) {
        return InvestorUser.fromJson(value.data()!);
      }
    });
    return null;
  }

  Future<void> updateUser(InvestorUser investorUser) async {
    await firestore.doc(investorUser.uid).update(investorUser.toJson());
  }

  DocumentReference<Map<String, dynamic>> getUserReference(String uid) {
    return firestore.doc(uid);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String uid) {
    return firestore.doc(uid).snapshots();
  }
}
