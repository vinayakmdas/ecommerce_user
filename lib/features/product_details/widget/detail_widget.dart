import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/widgets.dart';
import 'package:readmore/readmore.dart';

class DetailCustome {
  //  ^product brand
  static Widget brandname(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            color: AppColors.badges,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  //  ^product Name
  static Widget productName(String productName) {
    return Row(
      children: [
        Text(
          productName
              .split(' ')
              .map((word) {
                if (word.isEmpty) {
                  return ' ';
                }
                return word[0].toUpperCase() + word.substring(1).toLowerCase();
              })
              .join(' '),
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  static Widget priseDetails(String price, String regulaPrice) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Regular Price (MRP)
        Text(
          "\$$regulaPrice",
          style: TextStyle(
            decoration: TextDecoration.lineThrough,
            fontSize: 20,
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(width: 12),

        // Sale Price
        Text(
          "\$$price",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: AppColors.appBar,
            height: 1,
          ),
        ),

        SizedBox(width: 12),

        // Discount Badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.subtittleIcon,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "-${_calculateDiscount(regulaPrice, price)}%",
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // Helper function
  static int _calculateDiscount(String oldPrice, String newPrice) {
    final mrp = int.tryParse(oldPrice) ?? 0;
    final sale = int.tryParse(newPrice) ?? 0;
    if (mrp == 0) return 0;
    return (((mrp - sale) / mrp) * 100).round();
  }

  static Widget descriptionHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ],
    );
  }

  static Widget descripiton(String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      Expanded(
      child: ReadMoreText(
        description,
        trimMode: TrimMode.Line,
        trimLines: 2,
        trimCollapsedText: 'Show more',
        trimExpandedText: 'Show less',
        style: TextStyle(color: AppColors.categoryTitle),
        moreStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.categoryTitle,
        ),
        lessStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.categoryTitle, // Show less color
        ),
      ),
    ),
      ],
    );
  }
}
