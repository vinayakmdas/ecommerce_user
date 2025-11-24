import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/cart/checkOut/widget/cart_Custome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

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
            return Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs;

          if (cartItems.isEmpty) {
            return Center(
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
                    final productId = data.id;

                   return Card(
  color: AppColors.container,       // SAME BG COLOR
  elevation: 3,                      // Slight shadow for premium feel
  shadowColor: Colors.black12,
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            // IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                data["images"][0],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12),

            // TITLE + PRICE + QTY
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  SizedBox(height: 6),

                  Text(
                    "₹ ${data["price"]}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.appBar,
                    ),
                  ),

                  SizedBox(height: 10),

                  quantityButtons(
                    qty: data["qty"],
                    onIncrease: () =>
                        CartCustome.increaseQty(productId),
                    onDecrease: () =>
                        CartCustome.decreaseQty(productId),
                  ),
                ],
              ),
            ),

            // DELETE ICON
            IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: AppColors.errormessage,
                size: 26,
              ),
              onPressed: () => CartCustome.removeItem(productId),
            ),
          ],
        ),

     SizedBox(height: 14),   // space instead of divider

// SAVE FOR LATER BUTTON (FULL WIDTH + BG COLOR)
InkWell(
  onTap: () => CartCustome.saveForLater(productId),
  borderRadius: BorderRadius.circular(12),
  child: Container(
    width: double.infinity,                // FULL WIDTH
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
      color: AppColors.categoryTitle,      // YOUR COLOR
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.bookmark_border,
          color: AppColors.white,
          size: 22,
        ),
        SizedBox(width: 6),
        Text(
          "Save for Later",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ],
    ),
  ),
),

      ],
    ),
  ),
);

                  },
                ),
              ),

              totalSection(cartItems)
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
        IconButton(
          icon: Icon(Icons.remove_circle_outline),
          onPressed: onDecrease,
        ),

        Text(
          qty.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: onIncrease,
        ),
      ],
    );
  }


  Widget totalSection(List cartItems) {
    num total = 0;

    for (var item in cartItems) {
      total += item["price"] * item["qty"];
    }

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 8),
      ]),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total: ₹ $total",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          ElevatedButton(
            onPressed: () {},
            child: Text("Checkout"),
          )
            ],
          )
    );
        }

         
     
  }

