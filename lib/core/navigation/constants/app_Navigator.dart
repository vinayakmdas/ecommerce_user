import 'package:flutter/material.dart';

class AppNavigator {
  static Future<T?> push<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<T?> pushReplacement<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushReplacement<T, T>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget page,
  ) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
