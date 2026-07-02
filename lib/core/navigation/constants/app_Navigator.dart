import 'package:flutter/material.dart';

class AppNavigator {
  static Route<T> _createPageRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.08, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOutCubic;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 350),
    );
  }

  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.push<T>(context, _createPageRoute<T>(page));
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static Future<T?> pushReplacement<T>(BuildContext context, Widget page) {
    return Navigator.pushReplacement<T, T>(
      context,
      _createPageRoute<T>(page),
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(BuildContext context, Widget page) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      _createPageRoute<T>(page),
      (route) => false,
    );
  }
}
