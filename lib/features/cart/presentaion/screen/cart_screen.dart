import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/screen/checkout_screen.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/screen/save_later.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.scafoldBaground,

       appBar: AppBar(
  backgroundColor: AppColors.appBar,
  elevation: 0,
  toolbarHeight: 80,   // ⬅️ INCREASED HEIGHT

  title: Text(
    "My Cart",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,
      color: AppColors.white,
    ),
  ), 

  bottom: PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: AppColors.addToCart,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: AppColors.white,
        unselectedLabelColor: AppColors.white.withOpacity(0.7),

        tabs: const [
          Tab(
            icon: Icon(Icons.shopping_cart_checkout),
            text: "Cart",
          ),
          Tab(
            icon: Icon(Icons.save),
            text: "Save for Later",
          ),
        ],
      ),
    ),
  ),
),


        body: const TabBarView(
          children: [
            CheckoutScreen(),
            SaveLater(),
          ],
        ),
      ),
    );
  }
}
