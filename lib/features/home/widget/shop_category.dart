import 'package:ecommerce_fasion/features/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  
  static Widget circleBrand() {
    List<Map<String, dynamic>> categoriesItem = [
      {
        'name': 'Shirts',
        'icon': FontAwesomeIcons.shirt,
          'gradient': [Color(0xFF30cfd0), Color(0xFF330867)]
      },
      {
        'name': 'Pants',
        'icon': FontAwesomeIcons.vest,
          'gradient': [Color(0xFF30cfd0), Color(0xFF330867)]
      },
      {
        'name': 'Shoes',
        'icon': FontAwesomeIcons.shoePrints,
        'gradient': [Color(0xFF30cfd0), Color(0xFF330867)]
      },
      {
        'name': 'Sunglasses',
        'icon': FontAwesomeIcons.glasses,
        'gradient': [Color(0xFF30cfd0), Color(0xFF330867)]
      },
      {
        'name': 'Watch',
        'icon': FontAwesomeIcons.clock,
        'gradient': [Color(0xFF30cfd0), Color(0xFF330867)]
      },
      {
        'name': 'Bags',
        'icon': FontAwesomeIcons.bagShopping,
      'gradient': [Color(0xFF30cfd0), Color(0xFF330867)]
      },
    ];
    
    return SizedBox(
      height: 130,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12),
        itemCount: categoriesItem.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              onTap: () {
                print('${categoriesItem[index]['name']} selected');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: categoriesItem[index]['gradient'],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: categoriesItem[index]['gradient'][0].withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Icon(
                      categoriesItem[index]['icon'],
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    categoriesItem[index]['name'],
                    style: TextStyle( 
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                      letterSpacing: 0.2,
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