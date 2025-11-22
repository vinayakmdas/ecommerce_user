import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/cart/checkOut/presentation/checkout_screen.dart';
import 'package:ecommerce_fasion/features/cart/save_later/presentation/save_later.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:  2,
      child:  Scaffold(
      
    appBar: AppBar(
        bottom:  TabBar(
          labelColor: AppColors.addToCart,
          dividerColor: Colors.green,
          tabs: [

          Tab(
            icon: Icon(Icons.shopping_cart_checkout),
               text: "Cart",
          ),
           Tab(
         text: "Save for Later",
  icon: Icon(Icons.save),
          )
        ]),
      ),

      body: TabBarView(
          children: [
          CheckoutScreen(),
          SaveLater()
          ],
      )));
  }
}