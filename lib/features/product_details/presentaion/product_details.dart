import 'package:ecommerce_fasion/features/product_details/widget/image_container.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> productData;
  final String productId;

  const ProductDetailsScreen({
    super.key,
    required this.productData,
    required this.productId,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  List<dynamic> get _images {
    final variants = widget.productData["variants"] as List? ?? [];
    return variants.isNotEmpty ? variants.first['images'] ?? [] : [];
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.productData["productName"] ?? "Unnamed";
    final description = widget.productData["description"] ?? "No description";

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (_images.isNotEmpty)  Imagecontainer(
              images: _images,
              currentPage: currentPage,
              onPageChanged: (i) => setState(() => currentPage = i),
              controller: _pageController,
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}