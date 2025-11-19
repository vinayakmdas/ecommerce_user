import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/favorites/widget/favorites_custome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
       final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scafoldBaground,
        title: Text(
          'My Favorites',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    
    body:  StreamBuilder <List<Map<String,dynamic>> >(
      stream: FavoritesCustome.getFavoriteProducts(user!.uid) 
      , builder:   (context, snapshot){

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No favorites yet ❤️",
                style: TextStyle(fontSize: 18),
              ),
            );
          }
  final favorites = snapshot.data!;

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final item = favorites[index];

              return Card(
  color: AppColors.container,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  elevation: 3,
  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),

  child: Container(
    padding: EdgeInsets.all(12),
    child: Row(
      children: [
        // =======================
        // Product Image
        // =======================
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item["images"][0],
            width: 110,
            height: 110,
            fit: BoxFit.cover,
          ),
        ),

        SizedBox(width: 15),

        // =======================
        // Text Section
        // =======================
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item["brandId"] ?? "",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              SizedBox(height: 4),

              Text(
                item["productName"] ?? "",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 6),

              Text(
                "₹${item['price']}",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              SizedBox(height: 6),

             
            ],
          ),
        ),

       
        Align(
          alignment: Alignment.topRight,
          child: InkWell(
            onTap: () {
              FavoritesCustome.removeFavorite(user.uid, item["id"]);
            },
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Icon(Icons.favorite, color: Colors.red),
            ),
          ),
        ),
      ],
    ),
  ),
);

            },
          );
      }),
    );

  }
}
