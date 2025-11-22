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
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.network(
                              data["images"][0],
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          
                            title: Text(
                              data["productName"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("₹ ${data["price"]}"),
                          
                                SizedBox(height: 8),
                          
                                quantityButtons(
                                  qty: data["qty"],
                                  onIncrease: () => CartCustome.increaseQty(productId),
                                  onDecrease: () => CartCustome.decreaseQty(productId),
                                )
                              ],
                            ),
                          
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => CartCustome.removeItem(productId),
                            ),
                          ),

                          Divider(color: AppColors.grey,)
                          ,InkWell(
  onTap: () {
                                CartCustome.saveForLater(productId);

  },
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.bookmark_border,
          color: AppColors.grey, // or any color you want
          size: 22,
        ),
        SizedBox(width: 6),
        Text(
          "Save for Later",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
        ),
      ],
    ),
  ),
)

                        ],
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

