import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartCustome {
  static Future<void> increaseQty(String cartItemId) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final ref = FirebaseFirestore.instance
        .collection("cart")
        .doc(userId)
        .collection("items")
        .doc(cartItemId);

    final doc = await ref.get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final int currentQty = data["qty"] ?? 0;
      final String productId = data["id"] ?? "";
      final int variantIndex = data["selectedVariantIndex"] ?? 0;

      if (productId.isNotEmpty) {
        final productDoc = await FirebaseFirestore.instance
            .collection("products")
            .doc(productId)
            .get();

        if (productDoc.exists) {
          final productData = productDoc.data() as Map<String, dynamic>;
          final List<dynamic> variants = productData["variants"] as List? ?? [];
          if (variantIndex >= 0 && variantIndex < variants.length) {
            final variant = variants[variantIndex] as Map? ?? {};
            final int maxStock = (variant["quantity"] as int?) ?? 5;
            if (currentQty < maxStock) {
              await ref.update({"qty": FieldValue.increment(1)});
            }
          } else {
            await ref.update({"qty": FieldValue.increment(1)});
          }
        } else {
          await ref.update({"qty": FieldValue.increment(1)});
        }
      } else {
        await ref.update({"qty": FieldValue.increment(1)});
      }
    }
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

  static final _firestore = FirebaseFirestore.instance;

  static final _auth = FirebaseAuth.instance;

  static Future<void> saveForLater(String docId) async {
    final userId = _auth.currentUser!.uid;

    DocumentSnapshot itemSnapshtot = await _firestore
        .collection("cart")
        .doc(userId)
        .collection('items')
        .doc(docId)
        .get();

    if (!itemSnapshtot.exists) return;

    final data = itemSnapshtot.data() as Map<String, dynamic>;

    await _firestore
        .collection("SaveForLater")
        .doc(userId)
        .collection("items")
        .doc(docId)
        .set(data);

    await removeItem(docId);
  }
}
