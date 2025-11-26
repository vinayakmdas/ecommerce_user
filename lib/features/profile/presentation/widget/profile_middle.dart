import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';

class ProfileMiddleCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _item("Orders", Icons.shopping_bag_outlined),
          const SizedBox(width: 12),
          _item("Favorites", Icons.favorite_border),
          const SizedBox(width: 12),
          _item("Completed", Icons.check_circle_outline),
        ],
      ),
    );
  }

  Widget _item(String title, IconData icon) {
    return Expanded(
      child: Container(
     
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
            color: AppColors.circleavatarBaground,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Colors.black),
            const SizedBox(height: 6),
            Text("0", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
