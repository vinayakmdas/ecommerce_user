import 'package:flutter/material.dart';

class AppGradients {
  static const LinearGradient mainGradient = LinearGradient(
    colors: [
      Colors.teal,
      Colors.white,
      Colors.teal,
      Colors.white
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class Splashscreenwidget {

 //^ Background Image for Spla Screen
  static Widget buildBackgroundImage(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        'assets/splashscreen_logo/splashscreen.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}