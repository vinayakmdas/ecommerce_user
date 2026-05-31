import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderService {

  static Future<void> placeOrder({
    required String paymentId,
    required String paymentMethod,
    required int totalAmount,
    required String address,
    required String email,
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

    final String sellerId = cartItems.first["sellerId"]?.toString() ?? "";

    // 2️⃣ Create Order
    final orderRef = firestore.collection("orders").doc();
    final String displayOrderId =
        "#ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";

    final List<Map<String, dynamic>> itemsList = [];
    for (var item in cartItems) {
      final data = item.data();
      final String productId = data["id"] ?? item.id;
      final int qty = data["qty"] ?? 1;
      final String image = (data["images"] is List && (data["images"] as List).isNotEmpty)
          ? data["images"][0]
          : "";
      itemsList.add({
        "productId": productId,
        "productName": data["productName"] ?? "",
        "price": data["price"] ?? 0,
        "qty": qty,
        "sellerId": data["sellerId"] ?? "",
        "image": image,
        "color": data["color"] ?? "",
        "size": data["size"] ?? "",
      });
    }

    await orderRef.set({
      "userId": userId,
      "amount": totalAmount,
      "totalAmount": totalAmount,
      "paymentId": paymentId,
      "paymentMethod": paymentMethod,
      "status": "not Delivered",
      "createdAt": FieldValue.serverTimestamp(),
      "sellerId": sellerId,
      "items": itemsList,
    });

    // 3️⃣ Add Items to Order & Reduce Stock
    for (var item in cartItems) {
      final data = item.data();
      final String productId = data["id"] ?? item.id;
      final int selectedVariantIndex = data["selectedVariantIndex"] ?? 0;
      final int qty = data["qty"] ?? 1;
      final String image = (data["images"] is List && (data["images"] as List).isNotEmpty)
          ? data["images"][0]
          : "";

      // Add item to order
      await orderRef.collection("items").add({
        "adress": address,
        "orderId": displayOrderId,
        "productId": productId,
        "productName": data["productName"],
        "price": data["price"],
        "qty": qty,
        "sellerId": data["sellerId"],
        "sellerAmount": data["price"] * qty,
        "image": image,
        "status": "pending",
        "color": data["color"] ?? "",
        "size": data["size"] ?? "",
      });

      // Transactionally reduce product variant quantity
      final productRef = firestore.collection("products").doc(productId);
      await firestore.runTransaction((transaction) async {
        final productDoc = await transaction.get(productRef);
        if (productDoc.exists) {
          final productData = productDoc.data() as Map<String, dynamic>;
          final List<dynamic> variants = List.from(productData["variants"] ?? []);
          if (selectedVariantIndex >= 0 && selectedVariantIndex < variants.length) {
            final Map<String, dynamic> variant = Map<String, dynamic>.from(variants[selectedVariantIndex] as Map);
            final int currentQuantity = (variant["quantity"] as int?) ?? 0;
            final int newQuantity = (currentQuantity - qty).clamp(0, double.infinity).toInt();
            variant["quantity"] = newQuantity;
            variants[selectedVariantIndex] = variant;
            transaction.update(productRef, {"variants": variants});
          }
        }
      });
    }

    // 4️⃣ Clear Cart
    for (var item in cartItems) {
      await item.reference.delete();
    }
  }
}