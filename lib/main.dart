import 'package:ecommerce_fasion/features/auth/presentation/loginScreen/screens/loginScreen.dart';
import 'package:ecommerce_fasion/features/auth/presentation/signup/screens/signup_screen.dart';
import 'package:ecommerce_fasion/features/category_Screen.dart/screen/category_scren.dart';
import 'package:ecommerce_fasion/features/home_screen/screen/homescreen.dart';
import 'package:ecommerce_fasion/features/splash/splash.dart';
import 'package:ecommerce_fasion/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  final _router  =GoRouter(
    initialLocation: '/Splash',
 routes: [

  GoRoute(
  path: '/Splash',
  builder: (context, state) => const SplashAnimationScreen(),
 
 ),

 GoRoute(
  path: '/Login',
  builder: (context, state) => const Loginscreen(),
 
 ),

 GoRoute(
  path: '/SignUp',
  builder: (context, state) => const SignupScreen(),
 
 ),
  GoRoute(
  path: '/homescreen',
  builder: (context, state) => const HomeScreen(),
 
 ),
   GoRoute(
  path: '/categoryscreen',
  builder: (context, state) => const CategoryScren(),
 
 )
 ]

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