import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/widgets.dart';

class SizeSelector extends StatelessWidget {
  final List variants;
  final int selectedIndex;
  final Function(int) onSelect;

  const SizeSelector({super.key, 
    required this.variants,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        variants.length,
        (index) {
          final size = variants[index]["selectedOptions"]?["attr_size_fashion"] ?? "";

          if (size.isEmpty) return SizedBox();

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: selectedIndex == index ? AppColors.blackColor :AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color:AppColors.grey),
              ),
              child: Text(
                size,
                style: TextStyle(
                  color: selectedIndex == index ?AppColors.white : AppColors.blackColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
