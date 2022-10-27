import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyi/models/funding.dart';

class FundingService {
  final firestoreRef = FirebaseFirestore.instance.collection("fundings");
  Future<bool> addFunding(Funding funding) async {
    bool isSuccess = true;
    await firestoreRef
        .doc(funding.startupUid)
        .set(funding.toJson())
        .catchError((err) {
      print(err.toString());
      isSuccess = false;
    });
    return isSuccess;
  }

  Future<Funding?> getFunding(String uid) async {
    await firestoreRef.doc(uid).get().then((value) {
      if (value.exists) {
        return Funding.fromJson(value.data()!);
      }
      return null;
    });
    return null;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getNormalfundingStream() {
    return firestoreRef.snapshots();
  }

  CollectionReference<Map<String, dynamic>> getCollectionReference() {
    return firestoreRef;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getFundingCollectionByCategory(
      String category) async {
    return getCollectionReference()
        .where('startupCategory', isEqualTo: category)
        .get();
  }
}
