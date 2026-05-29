// product_details_screen.dart
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/home/presentation/bloc/imageIndicator/image_indicator_bloc.dart';
import 'package:ecommerce_fasion/features/home/presentation/bloc/variant_bloc/variant_bloc.dart';
import 'package:ecommerce_fasion/features/home/presentation/widget/product_details/widget/detail_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_animate/flutter_animate.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Helper: groups flat variant list by color
// Returns: { "red": [variantMap, variantMap], "blue": [...] }
// ─────────────────────────────────────────────────────────────────────────────
// Replace _groupByColor helper
Map<String, List<Map<String, dynamic>>> _groupByColor(List variants) {
  final Map<String, List<Map<String, dynamic>>> grouped = {};
  for (int i = 0; i < variants.length; i++) {
    final v = Map<String, dynamic>.from(variants[i] as Map);
    v['_flatIndex'] = i; // ✅ store original index inside the copy
    final color = ((v["colro"] as String?) ?? "default").trim().toLowerCase();
    grouped.putIfAbsent(color, () => []).add(v);
  }
  return grouped;
}
// ─────────────────────────────────────────────────────────────────────────────
// State holder (plain class — lives in StatefulWidget state)
// ─────────────────────────────────────────────────────────────────────────────
class _Selection {
  final String color;       // e.g. "red"
  final int variantIndex;   // index in the ORIGINAL flat variants list

  const _Selection({required this.color, required this.variantIndex});
}

// ─────────────────────────────────────────────────────────────────────────────
// ProductDetailsScreen
// ─────────────────────────────────────────────────────────────────────────────
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
  final ValueNotifier<bool> isFavorite = ValueNotifier(false);

  // ── Selection state ────────────────────────────────────────────────────────
  late List<Map<String, dynamic>> _variants;
  late Map<String, List<Map<String, dynamic>>> _grouped;
  late List<String> _uniqueColors;

  late String _selectedColor;
  late int _selectedVariantIndex; // index in flat _variants list
  int _quantity = 1;

  @override
void initState() {
  super.initState();

  // _groupByColor handles Map.from internally now, so just pass raw list
  _variants = (widget.productData["variants"] as List? ?? [])
      .map((v) => Map<String, dynamic>.from(v as Map))
      .toList();

  _grouped = _groupByColor(widget.productData["variants"] as List? ?? []); // ✅ pass original
  _uniqueColors = _grouped.keys.toList();

  _selectedColor = _uniqueColors.isNotEmpty ? _uniqueColors.first : "";
  _selectedVariantIndex = _firstIndexForColor(_selectedColor);

  _checkFavoriteStatus();
}

  // Returns the flat-list index of the first variant that matches [color]
  int _firstIndexForColor(String color) {
    for (int i = 0; i < _variants.length; i++) {
      final c = ((_variants[i]["colro"] as String?) ?? "").trim().toLowerCase();
      if (c == color) return i;
    }
    return 0;
  }

  String _resolveSize(Map options) {
    return options["attr_size_fashion"]?.toString() ??
          options["attr_waist_size"]?.toString() ??  
      options["attr_inches"]?.toString() ??
        options["size"]?.toString() ??
        "";
  }

  // ── Favorite helpers ───────────────────────────────────────────────────────
  Future<void> _checkFavoriteStatus() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection("favorites")
        .doc(userId)
        .collection("items")
        .doc(widget.productId)
        .get();
    isFavorite.value = doc.exists;
  }

  Future<void> _toggleFavorite() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final favRef = FirebaseFirestore.instance
        .collection("favorites")
        .doc(userId)
        .collection("items")
        .doc(widget.productId);

    final doc = await favRef.get();
    if (doc.exists) {
      await favRef.delete();
      isFavorite.value = false;
    } else {
      final v = _variants[_selectedVariantIndex];
      await favRef.set({
        "id": widget.productId,
        "productName": widget.productData["productName"] ?? "",
        "brandId": widget.productData["brandId"] ?? "",
        "description": widget.productData["description"] ?? "",
        "images": v["images"] ?? [],
        "price": v["price"] ?? 0,
        "regularPrice": v["regularPrise"] ?? 0,
        "createdAt": FieldValue.serverTimestamp(),
        "sellerId": widget.productData["sellerId"],
      });
      isFavorite.value = true;
    }
  }

  // ── Add to cart ────────────────────────────────────────────────────────────
  Future<void> _addToCart() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final cartRef = FirebaseFirestore.instance
        .collection("cart")
        .doc(userId)
        .collection("items")
        .doc(widget.productId);

    final doc = await cartRef.get();
    final variant = _variants[_selectedVariantIndex];

    if (doc.exists) {
      await cartRef.update({"qty": FieldValue.increment(_quantity)});
    } else {
      await cartRef.set({
        "id": widget.productId,
        "productName": widget.productData["productName"],
        "price": variant["price"],
        "regularPrice": variant["regularPrise"],
        "images": variant["images"],
        "qty": _quantity,
        "selectedVariantIndex": _selectedVariantIndex,
        "sellerId": widget.productData["sellerId"],
        "createdAt": FieldValue.serverTimestamp(),
      });
    }
  }

  // ── Selection handlers ─────────────────────────────────────────────────────

  /// Called when user taps a COLOR chip
  void _onColorSelected(String color) {
    setState(() {
      _selectedColor = color;
      // Jump to the first size of the newly selected color
      _selectedVariantIndex = _firstIndexForColor(color);
      _quantity = 1; // reset qty on color change
    });
    _pageController.jumpToPage(0);
  }

  /// Called when user taps a SIZE chip (only sizes of current color shown)
  void _onSizeSelected(int flatIndex) {
    setState(() {
      _selectedVariantIndex = flatIndex;
      _quantity = 1; // reset qty on size change
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_variants.isEmpty) {
      return const Scaffold(body: Center(child: Text("No variants found")));
    }

    final variant = _variants[_selectedVariantIndex];
    final images = (variant["images"] as List?)?.cast<String>() ?? [];
    final price = variant["price"] ?? 0;
    final regularPrice = variant["regularPrise"] ?? 0;
    final maxStock = (variant["quantity"] as int?) ?? 5;

    // Sizes for the currently selected color only
    final sizesForColor = _grouped[_selectedColor] ?? [];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ImageIndicatorBloc()),
      ],
      child: BlocBuilder<ImageIndicatorBloc, ImageIndicatorState>(
        builder: (context, imageState) {
          return Scaffold(
            backgroundColor: AppColors.scafoldBaground,
            body: Stack(
              children: [
                // ── Scrollable body ─────────────────────────────────
                CustomScrollView(
                  slivers: [
                    // ── Hero image SliverAppBar ──────────────────────
                    SliverAppBar(
                      expandedHeight: 340,
                      pinned: true,
                      backgroundColor: AppColors.scafoldBaground,
                      elevation: 0,
                      leading: GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_back, color: AppColors.appBar),
                        ),
                      ),
                      actions: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isFavorite,
                          builder: (_, fav, __) => GestureDetector(
                            onTap: _toggleFavorite,
                            child: Container(
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.white.withOpacity(0.9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                fav ? Icons.favorite : Icons.favorite_border,
                                color: fav ? AppColors.badges : AppColors.appBar,
                                size: 20,
                              ),
                            )
                                .animate(key: ValueKey(fav))
                                .scaleXY(
                                  begin: fav ? 0.6 : 1.0,
                                  end: 1.0,
                                  duration: 350.ms,
                                  curve: Curves.elasticOut,
                                ),
                          ),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Swipeable images
                            if (images.isNotEmpty)
                              PageView.builder(
                                controller: _pageController,
                                itemCount: images.length,
                                onPageChanged: (i) => context
                                    .read<ImageIndicatorBloc>()
                                    .add(ImageIndicatorEvent(i)),
                                itemBuilder: (_, i) => Image.network(
                                  images[i],
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                      Icons.image_not_supported,
                                      size: 80),
                                  loadingBuilder: (_, child, prog) =>
                                      prog == null
                                          ? child
                                          : Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColors.appBar,
                                              )),
                                ),
                              ).animate().fadeIn(duration: 500.ms),

                            // Bottom gradient
                            Positioned(
                              bottom: 0, left: 0, right: 0, height: 90,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      AppColors.scafoldBaground,
                                      AppColors.scafoldBaground.withOpacity(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Dot indicators
                            Positioned(
                              bottom: 16, left: 0, right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  images.length,
                                  (i) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(horizontal: 3),
                                    width: i == imageState.currentPage ? 18 : 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: i == imageState.currentPage
                                          ? AppColors.appBar
                                          : AppColors.grey.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ── Detail content ─────────────────────────────────
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([

                          DetailCustome.brandname(
                              widget.productData["brandId"] ?? ""),
                          const SizedBox(height: 4),

                          DetailCustome.productName(
                              widget.productData["productName"] ?? "Unnamed"),
                          const SizedBox(height: 14),

                          DetailCustome.priseDetails(
                            price.toString(),
                            regularPrice.toString(),
                          ),
                          const SizedBox(height: 24),

                          // ── COLOR selector (deduplicated) ────────────
                          _sectionLabel("Color"),
                          const SizedBox(height: 10),
                          _colorChips(),
                          const SizedBox(height: 20),

                          // ── SIZE selector (filtered by color) ────────
                          _sectionLabel("Size"),
                          const SizedBox(height: 10),
                          _sizeChips(sizesForColor),
                          const SizedBox(height: 20),

                          // ── Quantity ──────────────────────────────────
                          DetailCustome.quantitySelector(
                            quantity: _quantity,
                            maxStock: maxStock,
                            onIncrement: () {
                              if (_quantity < maxStock) {
                                setState(() => _quantity++);
                              }
                            },
                            onDecrement: () {
                              if (_quantity > 1) setState(() => _quantity--);
                            },
                          ),
                          const SizedBox(height: 24),

                          DetailCustome.descriptionHeading(),
                          const SizedBox(height: 8),
                          DetailCustome.descripiton(
                              widget.productData["description"] ??
                                  "No description"),
                        ]),
                      ),
                    ),
                  ],
                ),

                // ── Fixed bottom bar ────────────────────────────────────
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        20, 12, 20,
                        MediaQuery.of(context).padding.bottom + 12),
                    decoration: BoxDecoration(
                      color: AppColors.scafoldBaground.withOpacity(0.97),
                      border:
                          Border(top: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: Row(
                      children: [
                        DetailCustome.priceText(price.toString()),
                        const Spacer(),
                        DetailCustome.addtocartButton(
                          onPressed: () async {
                            await _addToCart();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                ..clearSnackBars()
                                ..showSnackBar(SnackBar(
                                  content: Row(children: [
                                    Icon(Icons.check_circle_outline,
                                        color: AppColors.white),
                                    const SizedBox(width: 10),
                                    Text(
                                      "$_quantity item${_quantity > 1 ? 's' : ''} added!",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]),
                                  backgroundColor: AppColors.appBar,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  margin: const EdgeInsets.all(16),
                                  duration: const Duration(seconds: 2),
                                ));
                            }
                          },
                        ),
                      ],
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 750.ms)
                      .slideY(begin: 1.0, curve: Curves.easeOut),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Color chips — one chip per UNIQUE color ──────────────────────────────
  Widget _colorChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _uniqueColors.map((color) {
        final isSelected = _selectedColor == color;
        return GestureDetector(
          onTap: () => _onColorSelected(color),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.appBar : AppColors.white,
              border: Border.all(
                color: isSelected ? AppColors.appBar : Colors.grey.shade300,
                width: isSelected ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              color[0].toUpperCase() + color.substring(1),
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.appBar,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn(duration: 400.ms, delay: 400.ms);
  }

  // ── Size chips — only sizes belonging to the selected color ─────────────
  Widget _sizeChips(List<Map<String, dynamic>> sizesForColor) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: sizesForColor.map((sizeVariant) {
      final flatIndex = sizeVariant['_flatIndex'] as int; // ✅ never -1
      final opts = sizeVariant["selectedOptions"];
      final sizeLabel = opts is Map ? _resolveSize(opts) : "";

      if (sizeLabel.isEmpty) return const SizedBox.shrink();

      final isSelected = _selectedVariantIndex == flatIndex;

      return GestureDetector(
        onTap: () => _onSizeSelected(flatIndex),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.appBar : AppColors.white,
            border: Border.all(
              color: isSelected ? AppColors.appBar : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            sizeLabel,
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.appBar,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      );
    }).toList(),
  ).animate().fadeIn(duration: 400.ms, delay: 450.ms);
}

  Widget _sectionLabel(String label) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: AppColors.grey,
        letterSpacing: 1.2,
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 350.ms);
  }
}