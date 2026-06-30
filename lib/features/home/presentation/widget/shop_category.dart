import 'package:ecommerce_fasion/features/home/presentation/screens/category_scren.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';

class ShopCategory {
  static Widget shopCategoryHeading() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Shop by Category',
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

  static Widget circleBrand(BuildContext context) {
    List<Map<String, dynamic>> categoriesItem = [
      {
        'name': 'Shirts',
        // ✅ Replace with actual shirt icon URL later
        'iconImage':
            'https://res.cloudinary.com/logocloudname/image/upload/v1781081794/Gemini_Generated_Image_qnf7ejqnf7ejqnf7-removebg-preview_s2fl2u.png',
        'image':
            'https://i.pinimg.com/1200x/6b/b6/64/6bb66426b5a41d816a5bff21f7704b4c.jpg',
        'categoryId': '8VjWE1FLzMg730rXpS0o',
      },
      {
        'name': 'Pants',
        // ✅ Replace with actual pants icon URL later
        'iconImage':
            "https://res.cloudinary.com/logocloudname/image/upload/v1781083622/circlepantimage_vmw8o6.png",
        'image':
            'https://res.cloudinary.com/logocloudname/image/upload/v1781083622/circlepantimage_vmw8o6.png',
        'categoryId': 'usQwmcFj6NQuKl5YpEg9',
      },
      {
        'name': 'Shoes',
        // ✅ Replace with actual shoes icon URL later
        'iconImage':
            'https://res.cloudinary.com/logocloudname/image/upload/v1781086245/shoeseimagecircle_oiixch.png',
        'image':
            'https://i.pinimg.com/1200x/9b/94/8a/9b948a909015f61161719a31e5165c96.jpg',
        'categoryId': 'jMCzId9h0BIzj6JGY56Q',
      },
      {
        'name': 'Sunglasses',
        // ✅ Replace with actual sunglasses icon URL later
        'iconImage':
            'https://res.cloudinary.com/logocloudname/image/upload/v1781085881/sunglasscircleiamge_e33cdi.png',
        'image':
            'https://i.pinimg.com/1200x/13/17/5a/13175a7be14ce6bb9da92a4c0deac33e.jpg',
        'categoryId': 'jMCzId9h0BIzj6JGY56Q',
      },
      {
        'name': 'Perfume',
        // ✅ Replace with actual watch icon URL later
        'iconImage':
            'https://res.cloudinary.com/logocloudname/image/upload/v1781086451/perfumeImageCircle_we39on.png',
        'image':
            'https://i.pinimg.com/1200x/44/0e/5e/440e5e07a537f3dbe5a466ce27c7e967.jpg',
        'categoryId': 'jMCzId9h0BIzj6JGY56Q',
      },
    ];

    return SizedBox(
      height: 110, // ⬅️ reduced from 130 to match target design
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: categoriesItem.length,
        itemBuilder: (context, index) {
          final item = categoriesItem[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryScreen(
                      imageUrl: item['image'],
                      name: item['name'],
                      categoryId: item['categoryId'],
                    ),
                  ),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80, // ⬅️ reduced from 70
                    height: 80, // ⬅️ reduced from 70
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.container,
                      border: Border.all(
                        color: const Color(0xFFD9D9D9),
                        width: 4,
                      ),
                    ),
                    child: ClipOval(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          10.0,
                        ), // ⬅️ padding so icon doesn't touch edges
                        child: Image.network(
                          item['iconImage'],
                          width: 85, // ⬅️ explicitly set width
                          height: 85, // ⬅️ explicitly set height
                          fit: BoxFit.cover, // ⬅️ fills the full circle
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image_outlined,
                              color: AppColors.blackColor,
                              size: 24,
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),
                  Text(
                    item['name'],
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12, // ⬅️ slightly smaller to match target
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
