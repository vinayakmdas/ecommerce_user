import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/product_details/bloc/imageIndicator/image_indicator_bloc.dart';
import 'package:ecommerce_fasion/features/product_details/bloc/variant_bloc/variant_bloc.dart';
import 'package:ecommerce_fasion/features/product_details/widget/detail_widget.dart';
import 'package:ecommerce_fasion/features/product_details/widget/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> productData;
  final String productId;

  ProductDetailsScreen({
    super.key,
    required this.productData,
    required this.productId,
  }) {
    checkFavoriteStatus();
  }

  final PageController _pageController = PageController();
  final ValueNotifier<bool> isFavorite = ValueNotifier(false);


  Future<void> checkFavoriteStatus() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection("favorites")
        .doc(userId)
        .collection("items")
        .doc(productId)
        .get();

    isFavorite.value = doc.exists;
  }

  // ===========================
  // ADD / REMOVE FROM FAVORITES
  // ===========================
  Future<void> toggleFavorite() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final favRef = FirebaseFirestore.instance
        .collection("favorites")
        .doc(userId)
        .collection("items")
        .doc(productId);

    final doc = await favRef.get();

    if (doc.exists) {
      // REMOVE FAVORITE
      await favRef.delete();
      isFavorite.value = false;
    } else {
      // ADD FAVORITE
      final firstVariant = (productData["variants"] as List).first;

      await favRef.set({
        "id": productId,
        "productName": productData["productName"] ?? "",
        "brandId": productData["brandId"] ?? "",
        "description": productData["description"] ?? "",
        "images": firstVariant["images"] ?? [],
        "price": firstVariant["price"] ?? 0,
        "regularPrice": firstVariant["regularPrise"] ?? 0,
        "createdAt": FieldValue.serverTimestamp(),
      });

      isFavorite.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImageIndicatorBloc()),
        BlocProvider(create: (_) => VariantBloc()),
      ],

      child: Scaffold(
   
        appBar: AppBar(
          backgroundColor: AppColors.productCard,
          actions: [
            ValueListenableBuilder(
              valueListenable: isFavorite,
              builder: (context, value, _) {
                return IconButton(
                  onPressed: () async {
                    await toggleFavorite();

                   
                  },
                  icon: Icon(
                    value ? Icons.favorite : Icons.favorite_border,
                    color: value ? AppColors.buyNow : AppColors.blackColor,
                  ),
                );
              },
            ),
            SizedBox(width: 14),
          ],
        ),

        body: BlocBuilder<VariantBloc, VariantState>(
          builder: (context, variantState) {
            final variants = productData["variants"] as List? ?? [];

            if (variants.isEmpty) {
              return Center(child: Text("No variants found"));
            }

            final variant = variants[variantState.selecedvarient];

            final images = variant["images"] ?? [];
            final price = variant["price"] ?? 0;
            final regularPrise = variant["regularPrise"] ?? 0;

            return BlocBuilder<ImageIndicatorBloc, ImageIndicatorState>(
              builder: (context, imageState) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // IMAGES SECTION
                      if (images.isNotEmpty)
                        Imagecontainer(
                          images: images,
                          currentPage: imageState.currentPage,
                          onPageChanged: (i) {
                            context.read<ImageIndicatorBloc>().add(
                                  ImageIndicatorEvent(i),
                                );
                          },
                          controller: _pageController,
                        ),

                      const SizedBox(height: 20),

                      // COLOR SELECTOR
                      Text(
                        "Colors",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: List.generate(variants.length, (index) {
                          final color = variants[index]["colro"] ?? "";

                          return GestureDetector(
                            onTap: () {
                              context.read<VariantBloc>().add(
                                    VariantEvent(index),
                                  );
                              context.read<ImageIndicatorBloc>().add(
                                    ImageIndicatorEvent(0),
                                  );
                              _pageController.jumpToPage(0);
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                
                                border: Border.all(
                                  color: variantState.selecedvarient == index
                                      ? AppColors.categoryTitle
                                      : AppColors.grey,
                                ),
                              ),
                              child: Text(
                                color.isEmpty ? "No Color" : color,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      // SIZE SELECTOR
                      Text(
                        "Size",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: List.generate(variants.length, (index) {
                          final size = variants[index]["selectedOptions"]
                                  ?["attr_size_fashion"] ??
                              "";

                          if (size.isEmpty) return SizedBox();

                          final isSelected =
                              variantState.selecedvarient == index;

                          return GestureDetector(
                            onTap: () {
                              context.read<VariantBloc>().add(
                                    VariantEvent(index),
                                  );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? AppColors.categoryTitle : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.grey),
                              ),
                              child: Text(
                                size,
                                style: TextStyle(
                                  color:
                                      isSelected ? AppColors.white : AppColors.blackColor,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 30),

                      DetailCustome.brandname(
                        productData["brandId"] ?? "no brand",
                      ),

                      const SizedBox(height: 20),

                  
                      DetailCustome.productName(
                        productData["productName"] ?? "Unnamed",
                      ),

                      const SizedBox(height: 20),

                   
                      DetailCustome.priseDetails(
                        price.toString(),
                        regularPrise.toString(),
                      ),

                      const SizedBox(height: 30),

                      DetailCustome.descriptionHeading(),
                      const SizedBox(height: 10),
                      DetailCustome.descripiton(
                        productData["description"] ?? "No description",
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),

        bottomNavigationBar: BlocBuilder<VariantBloc, VariantState>(
          builder: (context, variantState) {
            final variants = productData["variants"] as List? ?? [];

            if (variants.isEmpty) return SizedBox();

            final variant = variants[variantState.selecedvarient];
            final price = variant["price"] ?? 0;

            return SizedBox(
              height: 86.0,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Row(
                  children: [
                    DetailCustome.priceText(price.toString()),
                    Spacer(),
                    DetailCustome.addtocartButton ( 

                      onPressed: ()async{
                          final selectedVariant =
        context.read<VariantBloc>().state.selecedvarient;
   await addToCart(selectedVariant);
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Added to Cart")),
    );
                      }
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      
    );
  }
  Future<void> addToCart(int selectedVariant) async {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  final cartRef = FirebaseFirestore.instance
      .collection("cart")
      .doc(userId)
      .collection("items")
      .doc(productId);

  final doc = await cartRef.get();
  final variant = productData["variants"][selectedVariant];

  if (doc.exists) {
    // Already in cart → increase qty
    await cartRef.update({"qty": FieldValue.increment(1)});
  } else {
    // Add new product
    await cartRef.set({
      "id": productId,
      "productName": productData["productName"],
      "price": variant["price"],
      "regularPrice": variant["regularPrise"],
      "images": variant["images"],
      "qty": 1,
      "selectedVariantIndex": selectedVariant,
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
}

}
