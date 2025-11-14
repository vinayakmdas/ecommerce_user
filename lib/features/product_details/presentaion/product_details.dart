import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/product_details/bloc/imageIndicator/image_indicator_bloc.dart';
import 'package:ecommerce_fasion/features/product_details/bloc/variant_bloc/variant_bloc.dart';
import 'package:ecommerce_fasion/features/product_details/widget/detail_widget.dart';
import 'package:ecommerce_fasion/features/product_details/widget/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> productData;
  final String productId;

  ProductDetailsScreen({
    super.key,
    required this.productData,
    required this.productId,
  });

  final PageController _pageController = PageController();

  final int currentPage = 0;


  @override
  Widget build(BuildContext context) {
    // final name = productData["productName"] ?? "Unnamed";
    // final description = productData["description"] ?? "No description";
    // final brand = productData["brandId"] ?? "no brand";

    
    // final variants = productData["variants"] as List? ?? [];
// final firstVariant = variants.isNotEmpty ? variants.first : null;

// final price = firstVariant?["price"] ?? 0;
// final regularPrise = firstVariant?["regularPrise"] ?? 0;


    return MultiBlocProvider(
      providers: [
    BlocProvider(create: (_) => ImageIndicatorBloc()),
    BlocProvider(create: (_) => VariantBloc())
  ],
    
    
      child: Scaffold(
        backgroundColor: AppColors.scafoldBaground,
        appBar: AppBar(
          backgroundColor: AppColors.productCard,
          actions: [
          
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined))
          ,SizedBox(width: 14,)
        ],),
        body: BlocBuilder<VariantBloc, VariantState>(
  builder: (context, variantState) {
    final variants = productData["variants"] as List? ?? [];

    if (variants.isEmpty) {
      return Center(child: Text("No variants found"));
    }

    // ---- CURRENT VARIANT ----
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

              // ===============================
              //          PRODUCT IMAGES
              // ===============================
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

              // ===============================
              //          COLOR SELECTOR
              // ===============================
              Text("Colors", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),

              Row(
                children: List.generate(
                  variants.length,
                  (index) {
                    final color = variants[index]["colro"] ?? "";

                    return GestureDetector(
                      onTap: () {
                        context.read<VariantBloc>().add(VariantEvent(index));

                        // reset image indicator when variant changes
                        context.read<ImageIndicatorBloc>().add(ImageIndicatorEvent(0));
                        _pageController.jumpToPage(0);
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: variantState.selecedvarient == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        child: Text(
                          color.isEmpty ? "No Color" : color,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ===============================
              //          SIZE SELECTOR
              // ===============================
              Text("Size", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),

              Row(
                children: List.generate(
                  variants.length,
                  (index) {
                    final size =
                        variants[index]["selectedOptions"]?["attr_size_fashion"] ??
                            "";

                    if (size.isEmpty) return SizedBox();

                    final isSelected = variantState.selecedvarient == index;

                    return GestureDetector(
                      onTap: () {
                        context.read<VariantBloc>().add(VariantEvent(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // ===============================
              //          BRAND & NAME
              // ===============================
              DetailCustome.brandname(productData["brandId"] ?? "no brand"),

              const SizedBox(height: 20),

              DetailCustome.productName(productData["productName"] ?? "Unnamed"),

              const SizedBox(height: 20),

              // ===============================
              //          PRICE
              // ===============================
              DetailCustome.priseDetails(
                price.toString(),
                regularPrise.toString(),
              ),

              const SizedBox(height: 30),

              // ===============================
              //          DESCRIPTION
              // ===============================
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

      ),
    );
 
  }
}
