import 'package:ecommerce_fasion/core/splashscreen/presentation/screen/splash.dart';
import 'package:ecommerce_fasion/features/auth/presentation/screen/loginScreen.dart';
import 'package:ecommerce_fasion/features/auth/presentation/screen/signup_screen.dart';
import 'package:ecommerce_fasion/features/home/presentation/screens/homescreen.dart';
import 'package:ecommerce_fasion/core/navigation/presentaion/screen/navigator.dart';
import 'package:ecommerce_fasion/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}
   
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = GoRouter(
    initialLocation: '/Splash',
    routes: [
      GoRoute(
        path: '/Splash',
        builder: (context, state) => const SplashAnimationScreen(),

      ),
      GoRoute(
        path: '/bottomnScreen',
        builder: (context, state) => BottomNavigator(),
      ),
      GoRoute(path: '/Login', builder: (context, state) => const Loginscreen()),

      GoRoute(
        path: '/SignUp',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/homescreen',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,

      // home: SplashAnimationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
