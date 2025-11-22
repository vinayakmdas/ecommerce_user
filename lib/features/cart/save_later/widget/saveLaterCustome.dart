import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Savelatercustome {







   static Future<void> moveToCart(String docId, Map<String, dynamic> data) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
     final  firestore = FirebaseFirestore.instance;

    await firestore
        .collection("cart")
        .doc(userId)
        .collection("items")
        .doc(docId)
        .set(data);

    await firestore
        .collection("SaveForLater")
        .doc(userId)
        .collection("items")
        .doc(docId)
        .delete();
  }
}