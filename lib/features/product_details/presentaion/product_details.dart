import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/product_details/bloc/imageIndicator/image_indicator_bloc.dart';
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

  List<dynamic> get _images {
    final variants = productData["variants"] as List? ?? [];
    return variants.isNotEmpty ? variants.first['images'] ?? [] : [];
  }

  @override
  Widget build(BuildContext context) {
    final name = productData["productName"] ?? "Unnamed";
    final description = productData["description"] ?? "No description";
    final brand = productData["brandId"] ?? "no brand";

    
    final variants = productData["variants"] as List? ?? [];
final firstVariant = variants.isNotEmpty ? variants.first : null;

final price = firstVariant?["price"] ?? 0;
final regularPrise = firstVariant?["regularPrise"] ?? 0;

    return BlocProvider(
      create: (context) => ImageIndicatorBloc(),
      child: Scaffold(
        backgroundColor: AppColors.scafoldBaground,
        appBar: AppBar(
          backgroundColor: AppColors.productCard,
          actions: [
          
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined))
          ,SizedBox(width: 14,)
        ],),
        body: BlocBuilder<ImageIndicatorBloc, ImageIndicatorState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_images.isNotEmpty)
                    Imagecontainer(
                      images: _images,
                      currentPage: state.currentPage,
                      onPageChanged: (i) {
                        context.read<ImageIndicatorBloc>().add(
                          ImageIndicatorEvent(i),
                        );
                      },
                      controller: _pageController,
                    ),

                  const SizedBox(height: 28),
                  Padding(
                    padding: const EdgeInsets.only(left: 26),
                    child: Column(
                      children:[
                        DetailCustome.brandname(brand),
                        SizedBox(height: 20,),
                        DetailCustome.productName(name),
                        SizedBox(height: 26,),
                         DetailCustome.priseDetails(price.toString(), regularPrise.toString()),
                         SizedBox(height: 24,),
                         DetailCustome.descriptionHeading(), 
                         SizedBox(height: 20,),
                         DetailCustome.descripiton(description)
                        ]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
