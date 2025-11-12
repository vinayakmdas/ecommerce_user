import 'package:ecommerce_fasion/features/home/widget/carousel_widget.dart';
import 'package:ecommerce_fasion/features/home/widget/shop_category.dart';
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
              Padding(
              padding: const EdgeInsets.only(left: 9,top: 35 ),
                child: Column(
                  children: [
                    ShopCategory.shopCategoryHeading(),
                    SizedBox(height: 15,),
                    ShopCategory.circleBrand(context)
                  ], 
                ),
              )
            ],
          ), 
        ),
      ),
    );
  }
}
