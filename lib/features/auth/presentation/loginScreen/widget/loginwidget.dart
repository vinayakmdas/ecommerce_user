import 'dart:ui';

import 'package:ecommerce_fasion/features/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginWidgets {
 





  //^ Background Image for Login Screen
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
  return Text(text,style: GoogleFonts.prata(color: Colors.white,fontSize: 34,fontWeight: FontWeight.w700));
}

static Widget appwelcomeText(){

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Welcome Back !",style: TextStyle(color:AppColors.tittle,fontSize: 30,fontWeight: FontWeight.bold
      ),)
    ],
  );
}
static Widget signInToShopping(){

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Sign in to Continue Shopping ",style: TextStyle(color: const Color.fromARGB(255, 121, 119, 119) ,fontSize: 17,fontWeight: FontWeight.w500),)
    ],
  );
}
static Widget emailHeading(){
return  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [   
    Text(
            "Email Adress",
            style: TextStyle(
              fontSize: 14,         
              fontWeight: FontWeight.w500,
              color: AppColors.caption,    
            )),
  ],
);


}
  // ^login Costume TextformField
 static Widget loginEmail(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    autovalidateMode: AutovalidateMode.onUserInteraction, // ✅ validates as user types
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

static Widget passwordHeading(){
return  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [   
    Text(
            "Password",
            style: TextStyle(
              fontSize: 14,         
              fontWeight: FontWeight.w500,
              color: AppColors.caption,    
            )),
  ],
);


}
  // ^login Custom TextFormField for Password
static Widget loginPassword(TextEditingController controller) {
  bool _isPasswordVisible = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return TextFormField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        autovalidateMode: AutovalidateMode.onUserInteraction, // ✅ validates live
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
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
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


  static Widget forgotPasswordText(){
    bool value = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Checkbox(value: value, onChanged:(newvalue){
          value= newvalue!;
        }),
               Text("Remember me",style: TextStyle(color: AppColors.caption,fontSize: 13 ,fontWeight: FontWeight.w500),),


        Spacer(),
        TextButton(onPressed: (){}, child: Text("Forgotton Password",style: TextStyle(color: AppColors.addToCart),))
      ]
    );
  }

// ^ Login Custom TextFormField for Password



// ^ or continue with google 

static Widget orContinueWithText(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Or continue with",style: TextStyle(color: AppColors.caption,fontSize: 16,fontWeight: FontWeight.w500),)
    ],
  );
}
    


static Widget googleSignInButton(){
  return SizedBox(
    width: double.infinity,
    height: 50,
    child: OutlinedButton.icon(
      onPressed: () {},
      icon: Image.asset(
        'assets/google_sign/google.png',
        height: 24,
        width: 24,
      ),
      label: const Text(
        "Sign in with Google",
        style: TextStyle(fontSize: 18, color: Colors.black),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
  );
}

// ^moving to signup page 

static Widget moveToSignUpPage(BuildContext context){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Don't have an account?",style: TextStyle(color: AppColors.caption,fontSize: 14,fontWeight: FontWeight.w500),),
      TextButton(onPressed: (){
         context.push('/SignUp'); 
      }, child: Text("Sign Up",style: TextStyle(color: AppColors.addToCart,fontSize: 14,fontWeight: FontWeight.w600),))
    ],
  );  

}

// static Future<void> storingDataSharedPrefence(String  email ,password) async {
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

//    String  key =  email;

//    String   value = password;

// await sharedPreferences.setString(key, email);
//  await sharedPreferences.setString(value, password);
// await sharedPreferences.setBool('isLoggedIn', true);
// }


}
