import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/navigation/constants/app_Navigator.dart';
import 'package:ecommerce_fasion/core/navigation/presentaion/screen/navigator.dart';

import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidgets {
  //^ Background Image for Login Screen

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Widget buildBackgroundImage(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        'assets/splashscreen_logo/WhatsApp Image 2025-07-31 at 12.32.56_7e8f3943.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  // ^login Costume Text

  static Widget loginText(String text) {
    return Text(
      text,
      style: GoogleFonts.prata(
        color: Colors.white,
        fontSize: 34,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static Widget appwelcomeText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Welcome Back !",
          style: TextStyle(
            color: AppColors.tittle,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  static Widget signInToShopping() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sign in to Continue Shopping ",
          style: TextStyle(
            color: const Color.fromARGB(255, 121, 119, 119),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  static Widget emailHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Email Adress",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.caption,
          ),
        ),
      ],
    );
  }

  // ^login Costume TextformField
  static Widget loginEmail(TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      autovalidateMode:
          AutovalidateMode.onUserInteraction, // ✅ validates as user types
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }

        // ✅ simple and effective email validation regex
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email address';
        }

        return null; // ✅ means valid
      },
      decoration: InputDecoration(
        hintText: "Enter your email",
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  static Widget passwordHeading() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.caption,
          ),
        ),
      ],
    );
  }

  // ^login Custom TextFormField for Password
  static Widget loginPassword(TextEditingController controller) {
    bool isPasswordVisible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextFormField(
          controller: controller,
          obscureText: !isPasswordVisible,
          autovalidateMode:
              AutovalidateMode.onUserInteraction, // ✅ validates live
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            } else if (value.length < 6) {
              return 'Password must be at least 6 characters long';
            }
            // else if (!RegExp(r'[A-Z]').hasMatch(value)) {
            //   return 'Include at least one uppercase letter';
            // }
            else if (!RegExp(r'[0-9]').hasMatch(value)) {
              return 'Include at least one number';
            }
            return null; // ✅ means valid
          },
          decoration: InputDecoration(
            hintText: "Enter your password",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
        );
      },
    );
  }

  static Widget forgotPasswordText() {
    bool value = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Checkbox(
          value: value,
          onChanged: (newvalue) {
            value = newvalue!;
          },
        ),
        Text(
          "Remember me",
          style: TextStyle(
            color: AppColors.caption,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),

        Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            "Forgotton Password",
            style: TextStyle(color: AppColors.addToCart),
          ),
        ),
      ],
    );
  }

  // ^ Login Custom TextFormField for Password

  // ^ or continue with google

  static Widget orContinueWithText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Or continue with",
          style: TextStyle(
            color: AppColors.caption,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  static Widget googleSignInButton({
    required BuildContext context,
    required bool isLoading,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.black,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/google_sign/google.png',
                    height: 24,
                    width: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Sign in with Google",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
      ),
    );
  }

  // ^moving to signup page

  static Widget moveToSignUpPage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(
            color: AppColors.caption,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () {
            context.push('/SignUp');
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: AppColors.addToCart,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  static Future<void> signInWithGoogle(BuildContext context) async {
    // ✅ Capture the router BEFORE any await — it survives context disposal
    final router = GoRouter.of(context);

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user == null) return;

      await firestore.collection("user").doc(user.uid).set({
        'uid': user.uid,
        'username': user.displayName ?? '',
        'email': user.email ?? '',
        'profileImage': user.photoURL ?? '',
      });

      await storingDataSharedPrefence(user.email ?? '');

      // ✅ Use the captured router — no context needed, no mounted check needed
      AppNavigator.pushReplacement(context, BottomNavigator());
    } catch (e) {
      print("GOOGLE SIGN IN ERROR: $e");
      // ✅ Still safe to check mounted for SnackBar since it's UI-only
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Google Sign-In failed: $e")));
      }
    }
  }

  // ❌ Wrong — FirebaseAuthException will never catch SP errors
  static Future<void> storingDataSharedPrefence(String email) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('email', email);
      await sharedPreferences.setBool('isLogin', true);
    } on FirebaseAuthException catch (e) {
      // ← never triggered for SP
      print("⚠️ Firebase error: ${e.message}");
    } catch (e) {
      print("⚠️ General error: $e");
    }
  }
}
