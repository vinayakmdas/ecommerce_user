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
        Text(
          productName
              .split(' ')
              .map((word) {
                if (word.isEmpty) return ' ';
                return word[0].toUpperCase() + word.substring(1).toLowerCase();
              })
              .join(' '),
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
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

// ─────────────────────────────────────────────
//  ProductDetailScreen — full ready-to-use page
// ─────────────────────────────────────────────

class ProductDetailScreen extends StatefulWidget {
  // Replace with your actual product model
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  // ── Dummy data — replace with your model fields ──
  final String brand        = "Jordan";
  final String productName  = "letegfe";
  final String price        = "55656";
  final String regularPrice = "9889";
  final String description  =
      "bgfhgjhgyuhgyugff ggggggggggggggggggggggggggggggggggggggggggg "
      "A premium performance sneaker built for athletes who demand style and speed. "
      "Crafted with breathable mesh upper and responsive cushioning for all-day comfort.";
  final int    maxStock     = 7;
  final List<String> images = [
    'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80',
    'https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=600&q=80',
    'https://images.unsplash.com/photo-1600269452121-4f2416e55c28?w=600&q=80',
  ];
  final List<String> sizes = ['5"', '6"', '7"', '8"', '9"'];

  // ── State ─────────────────────────────────────────
  int  _quantity     = 1;
  int  _selectedSize = 0;
  int  _currentImage = 0;
  bool _wishlisted   = false;

  void _increment() { if (_quantity < maxStock) setState(() => _quantity++); }
  void _decrement() { if (_quantity > 1)        setState(() => _quantity--); }

  void _addToCart() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle_outline, color: AppColors.white),
            SizedBox(width: 10),
            Text(
              "$_quantity item${_quantity > 1 ? 's' : ''} added to cart!",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: AppColors.appBar,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      body: Stack(
        children: [
          // ── Scrollable body ───────────────────────
          CustomScrollView(
            slivers: [
              // Image SliverAppBar
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: AppColors.scafoldBaground,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.arrow_back, color: AppColors.appBar),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () => setState(() => _wishlisted = !_wishlisted),
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _wishlisted ? Icons.favorite : Icons.favorite_border,
                        color: _wishlisted ? AppColors.badges : AppColors.appBar,
                        size: 20,
                      ),
                    )
                        .animate(key: ValueKey(_wishlisted))
                        .scaleXY(
                          begin: _wishlisted ? 0.6 : 1.0,
                          end: 1.0,
                          duration: 350.ms,
                          curve: Curves.elasticOut,
                        ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Swipeable image carousel
                      PageView.builder(
                        itemCount: images.length,
                        onPageChanged: (i) => setState(() => _currentImage = i),
                        itemBuilder: (_, i) => Image.network(
                          images[i],
                          fit: BoxFit.cover,
                          loadingBuilder: (_, child, prog) => prog == null
                              ? child
                              : Center(child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.appBar,
                                )),
                        ),
                      ).animate().fadeIn(duration: 500.ms),

                      // Bottom fade
                      Positioned(
                        bottom: 0, left: 0, right: 0, height: 80,
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
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              width: i == _currentImage ? 18 : 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: i == _currentImage
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

              // Detail content
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 120),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([

                    DetailCustome.brandname(brand),
                    SizedBox(height: 4),

                    DetailCustome.productName(productName),
                    SizedBox(height: 14),

                    DetailCustome.priseDetails(price, regularPrice),
                    SizedBox(height: 24),

                    // Size picker
                    _sectionLabel("Size"),
                    SizedBox(height: 10),
                    _sizeSelector(),
                    SizedBox(height: 20),

                    // ── QUANTITY ──────────────────────
                    DetailCustome.quantitySelector(
                      quantity: _quantity,
                      maxStock: maxStock,
                      onIncrement: _increment,
                      onDecrement: _decrement,
                    ),
                    SizedBox(height: 24),

                    DetailCustome.descriptionHeading(),
                    SizedBox(height: 8),
                    DetailCustome.descripiton(description),

                  ]),
                ),
              ),
            ],
          ),

          // ── Fixed bottom bar ──────────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  20, 12, 20, MediaQuery.of(context).padding.bottom + 12),
              decoration: BoxDecoration(
                color: AppColors.scafoldBaground.withOpacity(0.97),
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  // Wishlist button
                  GestureDetector(
                    onTap: () => setState(() => _wishlisted = !_wishlisted),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      width: 52, height: 52,
                      decoration: BoxDecoration(
                        color: _wishlisted
                            ? AppColors.badges.withOpacity(0.1)
                            : AppColors.white,
                        border: Border.all(
                          color: _wishlisted
                              ? AppColors.badges
                              : Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _wishlisted ? Icons.favorite : Icons.favorite_border,
                        color: _wishlisted ? AppColors.badges : AppColors.appBar,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),

                  Expanded(
                    child: DetailCustome.addtocartButton(onPressed: _addToCart),
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
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: AppColors.grey,
        letterSpacing: 1,
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 400.ms);
  }

  Widget _sizeSelector() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(
        sizes.length,
        (i) => GestureDetector(
          onTap: () => setState(() => _selectedSize = i),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 9),
            decoration: BoxDecoration(
              color: _selectedSize == i ? AppColors.appBar : AppColors.white,
              border: Border.all(
                color: _selectedSize == i
                    ? AppColors.appBar
                    : Colors.grey.shade300,
                width: _selectedSize == i ? 1.5 : 1,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              sizes[i],
              style: TextStyle(
                color: _selectedSize == i ? AppColors.white : AppColors.appBar,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 450.ms);
  }
}