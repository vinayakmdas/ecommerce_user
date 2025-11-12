import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashAnimationScreen extends StatefulWidget {
  const SplashAnimationScreen({super.key});

  @override
  State<SplashAnimationScreen> createState() => _SplashAnimationScreenState();
}

class _SplashAnimationScreenState extends State<SplashAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // 1️⃣ Setup animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // 2️⃣ Start animation
    _controller.forward();

    // 3️⃣ Navigate after small delay
    Timer(const Duration(seconds: 3), _checkLoginStatus);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 4️⃣ Check login status
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLogin = prefs.getBool('isLogin') ?? false;

    if (!mounted) return;

    if (isLogin) {
      context.go('/bottomnScreen'); 
    } else {
      context.go('/Login'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.asset(
                  'assets/splashscreen_logo/vincart logo.png',
                  width: 180,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
