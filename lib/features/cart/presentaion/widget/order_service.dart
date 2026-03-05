import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {

  static Future<void> placeOrder({
    required String paymentId,
    required int totalAmount,
  }) async {

    final userId = FirebaseAuth.instance.currentUser!.uid;

    final firestore = FirebaseFirestore.instance;

    // 1️⃣ Get Cart Items
    final cartSnapshot = await firestore
        .collection("cart")
        .doc(userId)
        .collection("items")
        .get();

    final cartItems = cartSnapshot.docs;

    if (cartItems.isEmpty) return;

    // 2️⃣ Create Order
    final orderRef = firestore.collection("orders").doc();

    await orderRef.set({
      "userId": userId,
      "totalAmount": totalAmount,
      "paymentId": paymentId,
      "status": "success",
      "createdAt": FieldValue.serverTimestamp(),
    });

    // 3️⃣ Add Items to Order
    for (var item in cartItems) {

      final data = item.data();

      await orderRef.collection("items").add({
        "productId": item.id,
        "productName": data["productName"],
        "price": data["price"],
        "qty": data["qty"],
        "sellerId": data["sellerId"],
        "sellerAmount": data["price"] * data["qty"],
        "image": data["images"][0],
        "status": "pending",
      });
    }

    // 4️⃣ Clear Cart
    for (var item in cartItems) {
      await item.reference.delete();
    }
  }
}