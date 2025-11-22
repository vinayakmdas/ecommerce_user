import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/features/cart/save_later/widget/saveLaterCustome.dart';
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
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(data["images"][0], width: 60),

                  title: Text(data["productName"]),
                  subtitle: Text("₹ ${data["price"]}"),

                  trailing: ElevatedButton(
                    onPressed: () {
                      Savelatercustome.moveToCart(docId, data.data());
                    },
                    child: Text("Move to Cart"),
                  ),
                ),
              );
            },
          );
         })
    );
  }
}