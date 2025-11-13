import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      appBar: AppBar(
        title: Text(brandName),
        backgroundColor: AppColors.container,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: productCollection
            .where('brandId', isEqualTo: brandName)
            .where('categoryId', isEqualTo: categoryName)
            .snapshots(),
        builder: (context, snapshot) {
          // 🔄 Loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.categoryTitle),
            );
          }
      
          // ❌ No data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No products found for this brand & category.',
                style: TextStyle(fontSize: 16, color: AppColors.caption),
              ),
            );
          }
      
          final products = snapshot.data!.docs;
      
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 270,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              final productName = product['productName'] ?? 'Unnamed';
      
              // ✅ Handle images and price inside variants
              List<String> images = [];
              num price = 0;
              num regularPrice = 0;
      
              if (product['variants'] != null &&
                  product['variants'] is List &&
                  product['variants'].isNotEmpty) {
                final firstVariant = product['variants'][0];
      
                if (firstVariant['images'] != null &&
                    firstVariant['images'] is List) {
                  images = List<String>.from(firstVariant['images']);
                }
      
                if (firstVariant['price'] != null) {
                  price = firstVariant['price'];
                }
      
                if (firstVariant['regularPrise'] != null) {
                  regularPrice = firstVariant['regularPrise'];
                }
              }
      
              final imageUrl = images.isNotEmpty
                  ? images.first
                  : 'https://via.placeholder.com/300x300.png?text=No+Image';
      
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.container,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🖼️ Product Image
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                            child: Icon(Icons.broken_image,
                                size: 50, color: Colors.grey),
                          ),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          },
                        ),
                      ),
                    ),
      
                    // 🏷️ Product Info
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
      
                    // 💰 Price Section (Selling + Regular)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Text(
                            '₹$price',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (regularPrice > 0)
                            Text(
                              '₹$regularPrice',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                               Spacer(),
                            IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined))
                        ],
                      ),
                    ),
      
                    const SizedBox(height: 8),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
