

 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/features/auth/presentation/widget/loginwidget.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: 
    AppColors.scafoldBaground,
      body: Padding(
        padding: const EdgeInsets.only(top: 234,left: 25, right: 25),
        child: SingleChildScrollView(
          child: Form(
            key: formkey, 
            child: Column(
              children: [
              LoginWidgets.appwelcomeText(),
              SizedBox(height: 10,),
              LoginWidgets.signInToShopping(),
              SizedBox(height: 34,),
              
              LoginWidgets.emailHeading(),
              const SizedBox(height: 12), 
              LoginWidgets.loginEmail(emailcontroller),
                 const SizedBox(height: 20),
                 LoginWidgets.passwordHeading(),
              const SizedBox(height: 12), 
              LoginWidgets.loginPassword(passwordcontroller),
              SizedBox(height: 10,), 
              LoginWidgets.forgotPasswordText(),
              SizedBox(height: 24,),
               SizedBox(
              width: double.infinity, // takes full available width
              height: 50, // optional fixed height
              child: ElevatedButton(
                onPressed: () async{
                    
                 if(formkey.currentState!.validate()){
                  // Perform login action

                    //  log("${emailcontroller.text.toString()} and ${passwordcontroller.text.toString()}");

               await   checking(emailcontroller.text, passwordcontroller.text,context);
                     


                 }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
              SizedBox(height: 28,),
              LoginWidgets.orContinueWithText(),
                 const  SizedBox(height: 20,)
              ,
              LoginWidgets.googleSignInButton(),
              SizedBox(height: 20,),
              LoginWidgets.moveToSignUpPage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  checking (String email , password, BuildContext context )async{

  try{

    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      String uid = userCredential.user!.uid;

      DocumentSnapshot userdoc = await FirebaseFirestore.instance.collection("user").doc(uid).get();
  
      if(userdoc.exists){
         
          final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLogin', true);
        await prefs.setString('email', email);
         context.go('/homescreen');
   
      }
  }on FirebaseAuthException catch (e) {
    print("⚠️ Firebase error: ${e.message}");
  } catch (e) {
    print("⚠️ General error: $e");
  }
}}
