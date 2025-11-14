import 'package:ecommerce_fasion/features/product_details/bloc/imageIndicator/image_indicator_bloc.dart';
import 'package:ecommerce_fasion/features/product_details/widget/image_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> productData;
  final String productId;

    ProductDetailsScreen({
    super.key,
    required this.productData,
    required this.productId,
  });

  final PageController _pageController = PageController();

  int currentPage = 0;

  List<dynamic> get _images {
    final variants = productData["variants"] as List? ?? [];
    return variants.isNotEmpty ? variants.first['images'] ?? [] : [];
  }

  @override
  Widget build(BuildContext context) {
    final name = productData["productName"] ?? "Unnamed";
    final description = productData["description"] ?? "No description";

    return BlocProvider(
      create: (context) => ImageIndicatorBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text(name)),
        body: BlocBuilder<ImageIndicatorBloc, ImageIndicatorState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  if (_images.isNotEmpty)
                    Imagecontainer(
                      images: _images,
                      currentPage: state.currentPage,
                      onPageChanged: (i) {
                        context.read<ImageIndicatorBloc>().add(
                          ImageIndicatorEvent(i),
                        );
                      },
                      controller: _pageController,
                    ),
                  const SizedBox(height: 20),
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
