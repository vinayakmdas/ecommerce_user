import 'package:ecommerce_fasion/features/home/presentation/widget/carousel_widget.dart';
import 'package:ecommerce_fasion/features/home/presentation/widget/productGrid.dart';
import 'package:ecommerce_fasion/features/home/presentation/widget/shop_category.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselWidget.carousel(context),

              const SizedBox(height: 20),
              ShopCategory.shopCategoryHeading(),
              const SizedBox(height: 10),
              ShopCategory.circleBrand(context),
              const SizedBox(height: 20),
              const Productgrid(),
            ],
          ),
        ),
      ),
    );
  }
}
