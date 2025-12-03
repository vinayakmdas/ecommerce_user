import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart' show TextFormField, InputDecoration, OutlineInputBorder, Colors, ElevatedButton;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PersonolData {
  static Widget nameText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Full Name", style: TextStyle(color: AppColors.categoryTitle)),
      ],
    );
  }

  static Widget nameTextField({
    required TextEditingController controller,

  }) {
    return TextFormField(
       inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
      ],
      controller: controller,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

      decoration: InputDecoration(
        labelStyle:  TextStyle(color: AppColors.grey, fontSize: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color:AppColors.categoryTitle, width: 1.5),
        ),
       
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "Please enter your full name";
        }
        if (value.trim().length < 3) {
          return "Name must be at least 3 characters";
        }
        return null;
      },
    );
  }



  static Widget phonenuumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("Phone Number", style: TextStyle(color: AppColors.categoryTitle)),
      ],
    );
  }




  static Widget phoneTextField({
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.phone,

 
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(10), // limit to 10 digits
    ],

    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

    decoration: InputDecoration(

     

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.categoryTitle,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),

    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return "Please enter your phone number";
      }
      if (value.length != 10) {
        return "Phone number must be 10 digits";
      }
      return null;
    },
  );
}

 static Widget emailText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("E mail", style: TextStyle(color: AppColors.categoryTitle)),
      ],
    );
  }

  static Widget emailTextField({
  required TextEditingController controller,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,

    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),

    decoration: InputDecoration(
    


      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.categoryTitle,
          width: 1.5,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),

    validator: (value) {
      if (value == null || value.trim().isEmpty) {
        return "Please enter your email";
      }

      // simple email regex
      if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value.trim())) {
        return "Enter a valid email address";
      }

      return null;
    },
  );
}


static Widget  submitButton(){

return  SizedBox(
                    
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: AppColors.errormessage,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: Save Logic
                        print("Saved");
                      },
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );

}

}
