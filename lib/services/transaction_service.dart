import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyi/models/investor_user.dart';
import 'package:fyi/models/startup_user.dart';
import 'package:fyi/models/transaction.dart';

class TransactionService {
  final firebaseRef = FirebaseFirestore.instance.collection("transacion");
  Future<void> addTransaction(DateTime dateTime, TimeOfDay timeOfDay,
      String name, String uid, InvestorUser investorUser) async {
    String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    String time = "${timeOfDay.hour}.${timeOfDay.minute}";
    String message =
        'Attend the pitch deck on $date at $time in https://zoom.us/asdasdas';
    TransactionModel transaction = TransactionModel(
        startupName: name,
        investorName: investorUser.name,
        investorUid: investorUser.uid,
        message: message,
        startupUid: uid,
        status: "Pitch Deck");
    await firebaseRef
        .doc(transaction.combinedUid)
        .set(transaction.toJson())
        .catchError((err) => print(err));
  }

  Future<void> updateStatus(
      String status, TransactionModel transactionModel) async {
    transactionModel.status = status;
    if (status == "Success") {
      transactionModel.message = "Your funding has been verified";
    } else if (status == "Failed") {
      transactionModel.message = "Your funding has been canceled";
    }
    await firebaseRef
        .doc(transactionModel.combinedUid)
        .update(transactionModel.toJson())
        .catchError((err) => print(err));
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getTransactionStream(
      bool isStartup, String uid) {
    if (isStartup) {
      return firebaseRef.where('startupUid', isEqualTo: uid).snapshots();
    } else {
      return firebaseRef.where('investorUid', isEqualTo: uid).snapshots();
    }
  }
}
