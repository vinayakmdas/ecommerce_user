import 'package:ecommerce_fasion/core/navigation/constants/app_Navigator.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/profile/presentation/screens/adres_addingScreen.dart';
import 'package:flutter/material.dart';

class CheckoutWidget {

  static Widget contactText(){

    return Text("Contact Information",style: TextStyle(color: AppColors.blackColor,fontWeight: FontWeight.w600,fontSize: 23),);

  }

 static Widget  emailcontroller (TextEditingController emailcontroller){

  return TextFormField(
    controller: emailcontroller,
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    hintText: "Email",
    hintStyle: TextStyle(
      color: Colors.grey.shade500,
      fontSize: 14,
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 14,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.grey.shade300,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.black87,
        width: 1.2,
      ),
    ),
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return "Please enter email";
    }
    if (!value.contains("@")) {
      return "Enter valid email";
    }
    return null;
  },
);

 }
  static Widget savedAdressText(){

    return Text("Delivery Address",style: TextStyle(color: AppColors.blackColor,fontWeight: FontWeight.w600,fontSize: 23),);

  }

 static Widget elevatebutton(BuildContext context){
  return ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.categoryTitle,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
 
  ),
  onPressed: () {
    AppNavigator.push(context, AddAddressPage());
  },
  child: Row(
    children: [
      const Icon(Icons.add,color: AppColors.white,),
      const Text("Add New",style: TextStyle(color: AppColors.white),),
    ],
  ),
);

 }
 
 
 static Widget buildAddressCard({
  required bool isSelected,
  required String label,
  required String name,
  required String phone,
  required String address,
  required VoidCallback onTap,
  required VoidCallback onEdit,
  required VoidCallback onDelete,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? AppColors.categoryTitle : Colors.grey.shade300,
          width: isSelected ? 1.4 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.categoryTitle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white ,
                  ),
                ),
              ),
              SizedBox(width: 12,),
               Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: AppColors.categoryTitle,
              ),
              const Spacer(),

              /// RADIO
             

              const SizedBox(width: 6),

              /// EDIT
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

              const SizedBox(width: 8),

              /// DELETE
              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline, size: 20),
                color: Colors.red.shade400,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// NAME
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          /// PHONE
          Text(
            phone,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),

          const SizedBox(height: 6),

          /// ADDRESS
          Text(
            address,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
  );
}




static Widget paymentMethodCard({
  required String title,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected
              ? AppColors.categoryTitle
              : Colors.grey.shade300,
        ),
        color: isSelected ? Colors.orange.shade50 : Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: AppColors.categoryTitle,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}


 
}