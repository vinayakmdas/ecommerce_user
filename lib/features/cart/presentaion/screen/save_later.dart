import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/widget/saveLaterCustome.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class SaveLater extends StatelessWidget {
  const SaveLater({super.key});

  @override
  Widget build(BuildContext context) {
        final userId = FirebaseAuth.instance.currentUser!.uid;
    return   Scaffold(
      body: StreamBuilder(
        stream:  FirebaseFirestore.instance.collection("SaveForLater").doc(userId).collection('items').snapshots(),
         builder: (context, snapshot){
   if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!.docs;

          if (items.isEmpty) {

              return Center(child: Text("No items saved")); 
          }
           return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final data = items[index];
              final docId = data.id;

return Card(
  color: AppColors.container,           // soft cream background
  elevation: 3,
  shadowColor: Colors.black12,
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),

  child: Padding(
    padding: const EdgeInsets.all(14),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // 🔹 PRODUCT IMAGE
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

        // 🔹 PRODUCT DETAILS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data["productName"],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                 style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppColors.errormessage,
                    ),
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

              const SizedBox(height: 10),

              // 🔹 MOVE TO CART BUTTON (FULL-WIDTH)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Savelatercustome.moveToCart(docId, data.data());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.categoryTitle,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text(
                    "Move to Cart",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

            },
          );
         })
    );
  }
}