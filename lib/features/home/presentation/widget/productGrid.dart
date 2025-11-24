import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/brandItems/presentaion/widget/appBar_custome.dart';
import 'package:ecommerce_fasion/features/product_details/presentaion/screen/product_details.dart';
import 'package:ecommerce_fasion/routes/app_pages.dart';
import 'package:flutter/material.dart';

class Productgrid extends StatelessWidget {
  const Productgrid({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No products available.',
              style: TextStyle(fontSize: 16, color: AppColors.caption),
            ),
          );
        }

        final products = snapshot.data!.docs;
        return GridView.builder(
          shrinkWrap: true, 
  physics: NeverScrollableScrollPhysics(), 
          itemCount: products.length,
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 270,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
        
          itemBuilder: (context, index) {
            final doc = products[index];
        
            final product = doc.data();
            final variants = (product['variants'] ?? []) as List;
        
            String imageUrl =
                'https://via.placeholder.com/300x300.png?text=No+Image';
            num price = 0;
            num regularPrice = 0;
        
            if (variants.isNotEmpty) {
              final first = variants.first;
              final images = (first['images'] ?? []) as List;
        
              if (images.isNotEmpty) imageUrl = images.first;
        
              price = first['price'] ?? 0;
              regularPrice = first['regularPrise'] ?? 0;
            }
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
                onFavoriteTap: () {},
              ),
            );
          },
        );
      },
    );
  }
}
