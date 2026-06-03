import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/navigation/constants/app_Navigator.dart';
import 'package:ecommerce_fasion/core/navigation/presentaion/screen/navigator.dart';
import 'package:ecommerce_fasion/features/auth/presentation/widget/loginwidget.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool _isEmailLoading = false;
  bool _isGoogleLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      body: Padding(
        padding: const EdgeInsets.only(top: 234, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                LoginWidgets.appwelcomeText(),
                SizedBox(height: 10),
                LoginWidgets.signInToShopping(),
                SizedBox(height: 34),
                LoginWidgets.emailHeading(),
                const SizedBox(height: 12),
                LoginWidgets.loginEmail(emailcontroller),
                const SizedBox(height: 20),
                LoginWidgets.passwordHeading(),
                const SizedBox(height: 12),
                LoginWidgets.loginPassword(passwordcontroller),
                SizedBox(height: 10),
                LoginWidgets.forgotPasswordText(),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity, // takes full available width
                  height: 50, // optional fixed height
                  child: ElevatedButton(
                    onPressed: (_isEmailLoading || _isGoogleLoading)
                        ? null
                        : () async {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                _isEmailLoading = true;
                              });
                              await checking(
                                emailcontroller.text,
                                passwordcontroller.text,
                                context,
                              );
                              if (mounted) {
                                setState(() {
                                  _isEmailLoading = false;
                                });
                              }
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isEmailLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                  ),
                ),
                SizedBox(height: 28),
                LoginWidgets.orContinueWithText(),
                const SizedBox(height: 20),
                LoginWidgets.googleSignInButton(
                  context: context,
                  isLoading: _isGoogleLoading,
                  onPressed: () async {
                    setState(() {
                      _isGoogleLoading = true;
                    });
                    await LoginWidgets.signInWithGoogle(context);
                    if (mounted) {
                      setState(() {
                        _isGoogleLoading = false;
                      });
                    }
                  },
                ),
                SizedBox(height: 20),
                LoginWidgets.moveToSignUpPage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checking(String email, password, BuildContext context) async {
    // ✅ Capture router before awaits
    final router = GoRouter.of(context);

    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final DocumentSnapshot userdoc = await FirebaseFirestore.instance
          .collection("user")
          .doc(userCredential.user!.uid)
          .get();

      if (userdoc.exists) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('email', email);

        AppNavigator.pushReplacement(context, BottomNavigator());
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed')));
      }
    }
  }
}
