import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';


class CategoryWidget {
  static Widget imageContainer(BuildContext context, String imageUrl, String name) {
    return Container(
      width: double.infinity,
      height: 340,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 340,
          ),
          Positioned(
            bottom: 34,
            left: 20,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }



  static Widget shopHeading() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Shop by Brand',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  


}
}