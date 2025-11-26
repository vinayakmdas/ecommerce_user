import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';

class Profileheader {


    static Widget buildHeader() {
    return Container(
      height: 300,
      width: double.infinity,
      color: AppColors.categoryTitle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAvatar(),
          const SizedBox(height: 15),
          _buildName("Vinayak M"),
          const SizedBox(height: 10),
          _buildEmail("vinayakMdaz@gmail.com"),
        ],
      ),
    );
  }

   static Widget _buildAvatar() {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      CircleAvatar(
        radius: 49,
        backgroundColor: AppColors.circleBordercolor,
        child:  CircleAvatar(
          radius: 40,
       backgroundColor: AppColors.circleavatarBaground, 
         
          // backgroundImage: NetworkImage("your_image_url"),
        ),
      ),

      // Camera Icon
      Positioned(
        right: -5,
        bottom: -5,
        child: InkWell(
          onTap: (){
            print("circle avatar on tap");
          },
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
            child: const Icon(
              Icons.camera_alt,
              size: 18,
              color: Colors.black,
            ),
          ),
        ),
      )
    ],
  );
}


  static Widget _buildName(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static Widget _buildEmail(String email) {
    return Text(
      email,
      style: TextStyle(
        fontSize: 14,
        color: AppColors.white.withOpacity(0.9),
      ),
    );
  }
}