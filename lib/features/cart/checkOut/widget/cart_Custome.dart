import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartCustome {

static Future <void>increaseQty(String productID)async{
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final ref = FirebaseFirestore.instance.collection("cart").doc(userId).collection("items").doc(productID);

    await ref.update({"qty": FieldValue.increment(1)});
}



static Future<void> decreaseQty(String productId) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final ref = FirebaseFirestore.instance
      .collection("cart")
      .doc(userId)
      .collection("items")
      .doc(productId);

  final doc = await ref.get();
  int qty = doc["qty"];

  if (qty > 1) {
    await ref.update({"qty": qty - 1});
  } else {
    await ref.delete(); 
  }
  
  }


static Future<void> removeItem(String productId) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  await FirebaseFirestore.instance
      .collection("cart")
      .doc(userId)
      .collection("items")
      .doc(productId)
      .delete();
}


static final  _firestore = FirebaseFirestore.instance;

static final _auth =FirebaseAuth.instance;


static  Future<void >saveForLater (String docId)async{

final userId = _auth.currentUser!.uid;


  DocumentSnapshot itemSnapshtot = await _firestore.collection("cart")
  .doc(userId).
  collection('items')
  .doc(docId)
  .get();

  if(!itemSnapshtot .exists)return ;

  final data = itemSnapshtot.data() as Map <String,dynamic>; 

    await _firestore
        .collection("SaveForLater")
        .doc(userId)
        .collection("items")
        .doc(docId)
        .set(data);

await removeItem(docId);
} 


}