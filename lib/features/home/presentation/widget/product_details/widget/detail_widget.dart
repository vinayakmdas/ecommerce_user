import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 100.ms)
        .slideX(begin: -0.2, curve: Curves.easeOut);
  }

  //  ^product Name
  static Widget productName(String productName) {
    return Row(
      children: [
        Expanded(
          child: Text(
            productName
                .split(' ')
                .map((word) {
                  if (word.isEmpty) return ' ';
                  return word[0].toUpperCase() + word.substring(1).toLowerCase();
                })
                .join(' '),
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 200.ms)
        .slideY(begin: 0.3, curve: Curves.easeOut);
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
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scaleXY(end: 1.07, duration: 900.ms, curve: Curves.easeInOut),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 300.ms)
        .slideY(begin: 0.3, curve: Curves.easeOut);
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
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 550.ms);
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
              color: AppColors.categoryTitle,
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 600.ms);
  }

  static Widget priceText(String price) {
    return Text(
      "\$$price",
      style: TextStyle(
        fontSize: 32,
        color: AppColors.categoryTitle,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  NEW — Quantity Selector
  // ─────────────────────────────────────────────
  static Widget quantitySelector({
    required int quantity,
    required int maxStock,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return _QuantitySelector(
      quantity: quantity,
      maxStock: maxStock,
      onIncrement: onIncrement,
      onDecrement: onDecrement,
    );
  }

  static Widget addtocartButton({required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.addToCart,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add_shopping_cart, color: AppColors.white),
          SizedBox(width: 16),
          Text(
            "Add to Cart",
            style: TextStyle(color: AppColors.white, fontSize: 16),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 700.ms)
        .slideY(begin: 0.4, curve: Curves.easeOut);
  }
}

// ─────────────────────────────────────────────
//  _QuantitySelector — internal widget
// ─────────────────────────────────────────────

class _QuantitySelector extends StatelessWidget {
  final int quantity;
  final int maxStock;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const _QuantitySelector({
    required this.quantity,
    required this.maxStock,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Label + stock info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quantity",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.categoryTitle,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "$maxStock in stock",
                style: TextStyle(fontSize: 12, color: AppColors.grey),
              ),
            ],
          ),

          // − number + controls
          Row(
            children: [
              _buildQtyBtn(
                icon: Icons.remove,
                enabled: quantity > 1,
                onTap: onDecrement,
              ),

              SizedBox(width: 16),

              // Animated number switch
              AnimatedSwitcher(
                duration: Duration(milliseconds: 250),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: FadeTransition(opacity: anim, child: child),
                ),
                child: Text(
                  "$quantity",
                  key: ValueKey(quantity),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.appBar,
                  ),
                ),
              ),

              SizedBox(width: 16),

              _buildQtyBtn(
                icon: Icons.add,
                enabled: quantity < maxStock,
                onTap: onIncrement,
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: 500.ms)
        .slideY(begin: 0.3, curve: Curves.easeOut);
  }

  Widget _buildQtyBtn({
    required IconData icon,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: enabled ? AppColors.addToCart : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: enabled ? AppColors.white : Colors.grey.shade400,
          size: 18,
        ),
      ),
    );
  }
}

