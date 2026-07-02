import 'package:flutter/material.dart';

class AppRouter {
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

  static Future<T?> push<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push<T>(context, _createPageRoute<T>(page));
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    BuildContext context,
    Widget page, {
    TO? result,
  }) {
    return Navigator.pushReplacement<T, TO>(
      context,
      _createPageRoute<T>(page),
      result: result,
    );
  }

  static void pop<T extends Object?>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    BuildContext context,
    Widget page, {
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.pushAndRemoveUntil<T>(
      context,
      _createPageRoute<T>(page),
      predicate ?? (route) => false,
    );
  }
}
