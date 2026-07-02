
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/favorites/presentaion/widget/favorites_custome.dart';
import 'package:ecommerce_fasion/features/home/presentation/widget/appBar_custome_brandItem.dart';
import 'package:ecommerce_fasion/features/home/presentation/screens/product_details.dart';
import 'package:ecommerce_fasion/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BrandItem extends StatelessWidget {
  final String categoryName;
  final String brandName;

  const BrandItem({
    super.key,
    required this.brandName,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    final productCollection = FirebaseFirestore.instance.collection('products');
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: AppColors.container,
        actions: const [
          Icon(Icons.favorite_border_outlined),
          SizedBox(width: 12),
          Icon(Icons.shopping_cart_outlined),
          SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productCollection
            .where('brandId', isEqualTo: brandName)
            .where('categoryId', isEqualTo: categoryName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.categoryTitle),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No products found for this brand & category.',
                style: TextStyle(fontSize: 16, color: AppColors.caption),
              ),
            );
          }

          final products = snapshot.data!.docs;

          if (user == null) {
            return _buildGrid(context, products, const {});
          }

          return StreamBuilder<List<Map<String, dynamic>>>(
            stream: FavoritesCustome.getFavoriteProducts(user.uid),
            builder: (context, favSnapshot) {
              final favoriteList = favSnapshot.data ?? [];
              final favoriteIds = favoriteList.map((e) => e['id'] as String?).toSet();
              return _buildGrid(context, products, favoriteIds, user.uid);
            },
          );
        },
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<QueryDocumentSnapshot> products, Set<String?> favoriteIds, [String? userId]) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 270,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final doc = products[index];
        final product = doc.data() as Map<String, dynamic>;
        final variants = (product['variants'] ?? []) as List;

        String imageUrl = 'https://via.placeholder.com/300x300.png?text=No+Image';
        num price = 0;
        num regularPrice = 0;

        if (variants.isNotEmpty) {
          final first = variants.first;
          final images = (first['images'] ?? []) as List;
          if (images.isNotEmpty) imageUrl = images.first;
          price = first['price'] ?? 0;
          regularPrice = first['regularPrise'] ?? 0;
        }

        final isFav = favoriteIds.contains(doc.id);

        return GestureDetector(
          onTap: () {
            AppRouter.push(
              context,
              ProductDetailsScreen(productData: product, productId: doc.id),
            );
          },
          child: ProductCard(
            imageUrl: imageUrl,
            productName: product['productName'] ?? 'Unnamed',
            price: price,
            regularPrice: regularPrice,
            isFavorite: isFav,
            onFavoriteTap: () async {
              if (userId == null) return;
              final favRef = FirebaseFirestore.instance
                  .collection("favorites")
                  .doc(userId)
                  .collection("items")
                  .doc(doc.id);

              if (isFav) {
                await favRef.delete();
              } else {
                await favRef.set({
                  "id": doc.id,
                  "productName": product['productName'] ?? "",
                  "brandId": product['brandId'] ?? "",
                  "description": product['description'] ?? "",
                  "images": variants.isNotEmpty ? (variants.first['images'] ?? []) : [],
                  "price": price,
                  "regularPrice": regularPrice,
                  "createdAt": FieldValue.serverTimestamp(),
                  "sellerId": product['sellerId'],
                });
              }
            },
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms, delay: (index * 50).ms)
        .slideY(begin: 0.15, end: 0.0, curve: Curves.easeOutQuad);
      },
    );
  }
}
