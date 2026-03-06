import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  final List variants;
  final int selectedIndex;
  final Function(int) onSelect;

  const ColorSelector({super.key, 
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
          final color = variants[index]["colro"] ?? "";

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: EdgeInsets.only(right: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                    color: selectedIndex == index ? Colors.black : Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(color.isEmpty ? "No Color" : color),
            ),
          );
        },
      ),
    );
  }
}
