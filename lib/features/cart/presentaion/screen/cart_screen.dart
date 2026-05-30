import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/navigation/constants/app_Navigator.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/screen/checkout_screen.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/widget/cart_Custome.dart';
// import 'package:ecommerce_fasion/features/checkout/presentation/checkout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("cart")
            .doc(userId)
            .collection("items")
            .orderBy("createdAt", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 18)),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final data = cartItems[index];
                    final cartItemId = data.id;

                    return  TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
    duration: Duration(milliseconds: 350 + (index * 80)),
    curve: Curves.easeOut,
    builder: (context, value, child) => Opacity(
      opacity: value,
      child: Transform.translate(
        offset: Offset(0, 30 * (1 - value)),
        child: child,
      ),
    ),
                      child: Card(
                        color: AppColors.container,
                        elevation: 3,
                        shadowColor: Colors.black12,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      data["images"][0],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data["productName"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: AppColors.errormessage,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "₹ ${data["price"]}",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.appBar,
                                          ),
                                        ),
                                        
                                        // Display variant color & size if available
                                        if (data.data().containsKey("color") || data.data().containsKey("size")) ...[
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              if (data.data().containsKey("color") && data["color"].toString().isNotEmpty)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.categoryTitle.withOpacity(0.08),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    "Color: ${data["color"].toString()[0].toUpperCase() + data["color"].toString().substring(1)}",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: AppColors.categoryTitle,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              if (data.data().containsKey("color") && data["color"].toString().isNotEmpty && data.data().containsKey("size") && data["size"].toString().isNotEmpty)
                                                const SizedBox(width: 8),
                                              if (data.data().containsKey("size") && data["size"].toString().isNotEmpty)
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.categoryTitle.withOpacity(0.08),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: Text(
                                                    "Size: ${data["size"]}",
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color: AppColors.categoryTitle,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                        const SizedBox(height: 10),
                                        quantityButtons(
                                          qty: data["qty"],
                                          onIncrease: () =>
                                              CartCustome.increaseQty(cartItemId),
                                          onDecrease: () =>
                                              CartCustome.decreaseQty(cartItemId),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.errormessage,
                                      size: 26,
                                    ),
                                    onPressed: () =>
                                        CartCustome.removeItem(cartItemId),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              InkWell(
                                onTap: () =>
                                    CartCustome.saveForLater(cartItemId),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.categoryTitle,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.bookmark_border,
                                          color: AppColors.white),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Save for Later",
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              totalSection(context, cartItems),
            ],
          );
        },
      ),
    );
  }

  Widget quantityButtons({
  required int qty,
  required VoidCallback onIncrease,
  required VoidCallback onDecrease,
}) {
  return Row(
    children: [
      Container(
        decoration: BoxDecoration(
          color: AppColors.categoryTitle.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.categoryTitle.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove, size: 16),
              color: AppColors.categoryTitle,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: onDecrease,
            ),
            Container(width: 1, height: 16,
                color: AppColors.categoryTitle.withOpacity(0.3)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                qty.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.categoryTitle,
                ),
              ),
            ),
            Container(width: 1, height: 16,
                color: AppColors.categoryTitle.withOpacity(0.3)),
            IconButton(
              icon: const Icon(Icons.add, size: 16),
              color: AppColors.categoryTitle,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: onIncrease,
            ),
          ],
        ),
      ),
    ],
  );
}

  Widget totalSection(BuildContext context, List cartItems) {
    num total = 0;
    for (var item in cartItems) {
      total += item["price"] * item["qty"];
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [AppColors.container, AppColors.productCards],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total",
                  style:
                      TextStyle(color: AppColors.lessImportandText)),
              Text(
                "₹ $total",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.tittle,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.buyNow,
              padding:
                  const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
           onPressed: () {
  AppNavigator.push(
    context,
    CheckoutScreens(
      amount: total.toInt(),
    ),
  );
},

            child: const Text(
              "Checkout",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
