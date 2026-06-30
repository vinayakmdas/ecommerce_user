import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';

import 'package:flutter/material.dart';

class CarouselWidget {
  static List<Map<String, String>> carouselData = [
    {
      'image':
          'https://res.cloudinary.com/logocloudname/image/upload/v1780660077/47630fcd-22c9-4209-bd5c-830a384138e3.png',
      'text': 'Stylish Shirt ',
    },
    {
      'image':
          'https://res.cloudinary.com/logocloudname/image/upload/v1780660389/0135af6f-2ec8-4f3c-b1f0-7c9aa91faeda.png',
      'text': 'Casual Jeans ',
    },
    {
      'image':
          'https://res.cloudinary.com/logocloudname/image/upload/v1780660064/bf457405-2825-410b-ba4e-0e301bb06258.png',
      'text': 'T-Shirt –',
    },
    {
      'image':
          'https://res.cloudinary.com/logocloudname/image/upload/v1780660038/7cdfdbd6-5691-4214-9528-c507485689ac.png',
      'text': 'T-Shirt',
    },
    {
      'image':
          'https://res.cloudinary.com/logocloudname/image/upload/v1780660013/WhatsApp_Image_2026-06-05_at_5.07.03_PM_sixm96.jpg',
      'text': 'T-Shirt ',
    },
  ];

  static Widget carousel(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: CarouselSlider(
        items: carouselData
            .map(
              (item) => Stack(
                children: [
                  Image.network(item['image']!, fit: BoxFit.cover, width: 1000),

                  Positioned(
                    bottom: 34,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        item["text"]!,
                        style: TextStyle(
                          color: AppColors.categoryTitle,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
        options: CarouselOptions(
          height: 340,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          enlargeCenterPage: false,
        ),
      ),
    );
  }
}
