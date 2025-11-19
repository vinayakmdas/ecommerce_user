import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesCustome {


  static   Stream<List<Map<String, dynamic>>> getFavoriteProducts(String userId) {
  return FirebaseFirestore.instance
      .collection("favorites")
      .doc(userId)
      .collection("items")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => doc.data()).toList());
}

static Future<void> removeFavorite(String userId, String productId) async {
  await FirebaseFirestore.instance
      .collection("favorites")
      .doc(userId)
      .collection("items")
      .doc(productId)
      .delete();
}


}