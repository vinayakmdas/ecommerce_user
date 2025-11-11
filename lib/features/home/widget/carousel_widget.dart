import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

class CarouselWidget {
  static List<Map<String, String>> carouselData = [
    {
      'image':
          'https://i.pinimg.com/1200x/6b/b6/64/6bb66426b5a41d816a5bff21f7704b4c.jpg',
      'text': 'Stylish Shirt ',
    },
    {
      'image':
          'https://i.pinimg.com/1200x/05/e2/1c/05e21cb0736aac2b93b8efa9093c3b6c.jpg',
      'text': 'Casual Jeans ',
    },
    {
      'image':
          'https://i.pinimg.com/1200x/9b/94/8a/9b948a909015f61161719a31e5165c96.jpg',
      'text': 'T-Shirt –',
    },
    { 
      'image':
          'https://i.pinimg.com/1200x/13/17/5a/13175a7be14ce6bb9da92a4c0deac33e.jpg',
      'text': 'T-Shirt',
    },
    {
      'image':
          'https://i.pinimg.com/1200x/44/0e/5e/440e5e07a537f3dbe5a466ce27c7e967.jpg',
      'text': 'T-Shirt ',
    },
  ];

  static Widget carousel(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 340,
      child: CarouselSlider(
        items: carouselData
            .map(
              (item) => Stack(
                children: [
                  Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                    width: 1000,
                  ),
      
                  Positioned(
                    bottom: 34,
                    child: 
                  
                  Padding(
                    padding: const EdgeInsets.only(left: 20), 
                    child: Text(
                      item["text"]!,style: TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.bold,)
                    ),
                  )
                  )
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
