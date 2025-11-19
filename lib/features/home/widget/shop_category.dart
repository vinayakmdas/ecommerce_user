import 'package:ecommerce_fasion/features/category/presentaion/category_scren.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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
      'icon': FontAwesomeIcons.shirt,
      'gradient': [Color(0xFF30cfd0), AppColors.categoryTitle],
      'image': 'https://i.pinimg.com/1200x/6b/b6/64/6bb66426b5a41d816a5bff21f7704b4c.jpg',
      'categoryId' : '8VjWE1FLzMg730rXpS0o'
    },
    {
      'name': 'Pants',
      'icon': FontAwesomeIcons.vest,
      'gradient':[Color(0xFF30cfd0), AppColors.categoryTitle],
      'image': 'https://i.pinimg.com/1200x/05/e2/1c/05e21cb0736aac2b93b8efa9093c3b6c.jpg',
       'categoryId' : 'usQwmcFj6NQuKl5YpEg9'
    },
    {
      'name': 'Shoes',
      'icon': FontAwesomeIcons.shoePrints,
      'gradient':[Color(0xFF30cfd0), AppColors.categoryTitle],
      'image': 'https://i.pinimg.com/1200x/9b/94/8a/9b948a909015f61161719a31e5165c96.jpg',
        'categoryId' : 'jMCzId9h0BIzj6JGY56Q'
    },
    {
      'name': 'Sunglasses',
      'icon': FontAwesomeIcons.glasses,
      'gradient': [Color(0xFF30cfd0), AppColors.categoryTitle],
      'image': 'https://i.pinimg.com/1200x/13/17/5a/13175a7be14ce6bb9da92a4c0deac33e.jpg',
    },
    {
      'name': 'Watch',
      'icon': FontAwesomeIcons.clock,
      'gradient':[Color(0xFF30cfd0), AppColors.categoryTitle],
      'image': 'https://i.pinimg.com/1200x/44/0e/5e/440e5e07a537f3dbe5a466ce27c7e967.jpg',
    },
    ];

    return SizedBox(
      height: 130,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: categoriesItem.length,
        itemBuilder: (context, index) {
          final item = categoriesItem[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                // ✅ simple push navigation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryScreen(
                      imageUrl: item['image'],
                      name: item['name'],
                      categoryId:  item['categoryId'],
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: item['gradient'],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Icon(item['icon'], color: Colors.white, size: 28),
                  ),
                  SizedBox(height: 10),
                  Text(
                    item['name'],
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
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
