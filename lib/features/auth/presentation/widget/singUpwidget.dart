import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Signupwidget {



  static Widget appwelcomeText(){

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Sign Up & Start Shopping!",style: TextStyle(color:AppColors.tittle,fontSize: 30,fontWeight: FontWeight.bold
      ),)
    ],
  );
}

static Widget nameHeading(){
return  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [   
    Text(
            "Name",
            style: TextStyle(
              fontSize: 14,         
              fontWeight: FontWeight.w500,
              color: AppColors.caption,    
            )),
  ],
);


}
// ^singUp Costume TextformField
 static Widget userName(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "Please enter your name";
      } else if (value.length < 4) {
        return "Name must be at least 4 characters";
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: "Enter your name",
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: const Icon(Icons.person_outline, color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
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


// ^singUp Costume TextformField
  static Widget signUpMail(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    autovalidateMode: AutovalidateMode.onUserInteraction, // auto-check when typing

    decoration: InputDecoration(
      hintText: "Enter your email",
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      fillColor: Colors.white,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    ),


    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }

      final emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );

      if (!emailRegExp.hasMatch(value)) {
        return 'Please enter a valid email address';
      }

      return null; 
    },
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
static Widget passwordcontroller(TextEditingController controller) {
  bool isPasswordVisible = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return TextFormField(
        controller: controller,
        obscureText: !isPasswordVisible,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          } else if (value.length < 6) {
            return 'Password must be at least 6 characters';
          } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)').hasMatch(value)) {
            return 'Password must contain letters & numbers';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
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
          fillColor: Colors.white,
          filled: true,
        ),
      );
    },
  );
}

  static Widget conformpasswordHeading(){
return  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [   
    Text(
            "Re-Enter Password",
            style: TextStyle(
              fontSize: 14,         
              fontWeight: FontWeight.w500,
              color: AppColors.caption,    
            )),
  ],
);


}
  // ^login Custom TextFormField for Password
static Widget conformpassword(
  
  TextEditingController confirmController,
) {
  bool isPasswordVisible = false;

  return StatefulBuilder(
    builder: (context, setState) {
      return TextFormField(
        controller: confirmController,
        obscureText: !isPasswordVisible,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please confirm your password';
          } 
          return null;
        },
        decoration: InputDecoration(
          hintText: "Confirm your password",
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
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
          fillColor: Colors.white,
          filled: true,
        ),
      );
    },
  );
}

  static Widget phoneNumber(){
return  Row(
  mainAxisAlignment: MainAxisAlignment.start,
  children: [   
    Text(
            "Phone Number",
            style: TextStyle(
              fontSize: 14,         
              fontWeight: FontWeight.w500,
              color: AppColors.caption,    
            )),
  ],
);


}

// ^Signup Custom TextFormField for Phone Number
static Widget phoneNumberField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.phone,
    maxLength: 10,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'Phone number must contain only digits';
      } else if (value.length != 10) {
        return 'Phone number must be 10 digits';
      }
      return null;
    },
    decoration: InputDecoration(
      counterText: "",
      hintText: "Enter your phone number",
      hintStyle: const TextStyle(color: Colors.grey),
      prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      fillColor: Colors.white,
      filled: true,
    ),
  );
}





static Widget termAndCondition(){
    bool value = false;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(value: value, onChanged:(newvalue){
          value= newvalue!;
        }),
               Text("I agree and to the ",style: TextStyle(color: AppColors.caption,fontSize: 13 ,fontWeight: FontWeight.w500),),
TextButton(onPressed: (){}, child: Text("Terms",style: TextStyle(color: AppColors.addToCart))),
Text(" & ",style: TextStyle(color: AppColors.caption,fontSize: 13 ,fontWeight: FontWeight.w500),),
TextButton(onPressed: (){}, child: Text("Conditions",style: TextStyle(color: AppColors.addToCart))),

      ]
    );
  }



  static Widget moveToLoginPage(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?",style: TextStyle(color: AppColors.caption,fontSize: 13 ,fontWeight: FontWeight.w500),),
        TextButton(onPressed: (){

          context.pop();
        }, child: Text("Login",style: TextStyle(color: AppColors.addToCart),))
      ]
    );
  }
}