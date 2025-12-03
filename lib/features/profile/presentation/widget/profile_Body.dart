
import 'package:ecommerce_fasion/features/profile/data/service/profile_service.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/personoBloc/personol_bloc_bloc.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/personoBloc/personol_bloc_event.dart';
import 'package:ecommerce_fasion/features/profile/presentation/screens/adres%20_screen.dart';
import 'package:ecommerce_fasion/features/profile/presentation/screens/payment_screen.dart';
import 'package:ecommerce_fasion/features/profile/presentation/screens/personol_screen.dart';
import 'package:ecommerce_fasion/features/profile/presentation/screens/settingsScreen.dart';
import 'package:ecommerce_fasion/features/profile/presentation/screens/wishlist.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBody {
  static Widget buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),

            const SizedBox(height: 15),

           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell( 
                  
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AdressScreen()));
                  },
                   child: _quickAction(Icons.location_on_outlined, "Addresses", AppColors.adressbaground, AppColors.adressIcon )),

                InkWell(
                  onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentScreen()));
                  },
                  child: _quickAction(Icons.payment, "Payments", AppColors.paymentbaground,AppColors.paymentIcon)),
                InkWell(
                  onTap: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Wishlist()));
                  },
                  
                  child: _quickAction(Icons.shopping_bag_outlined, "Orderes", AppColors.orderbaground , AppColors.orderIcon)),
                InkWell(
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsSCreen()));
                  },
                  child: _quickAction(Icons.settings, "Settings", AppColors.settingbaground,AppColors.settingsIcon)),
              ],
            ),

            const SizedBox(height: 30),

            // Text(
            //   "Recent Orders",
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.w700,
            //     color: AppColors.blackColor,
            //   ),
            // ),

            // const SizedBox(height: 15),

            // Container(
            //   height: 140,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: AppColors.container,
            //     borderRadius: BorderRadius.circular(16),
            //   ),
            //   child: Center(
            //     child: Icon(
            //       Icons.inventory_2_outlined,
            //       size: 45,
            //       color: Colors.grey.shade500,
            //     ),
            //   ),
            // ),

         
          ],
        ),
      ),
    );
  }

  static Widget _quickAction(IconData icon, String label , Color bagroundColor, Color iconcolor) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: bagroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(icon, size: 30, color: iconcolor),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.blackColor
          ),
        ),
      ],
    );
  }


static Widget buildAccountList(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),

      Text(
        "Account",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ),

      const SizedBox(height: 15),

      _buildSettingTile(
        context,
        icon: Icons.person_3_outlined,
        title: "Personal Information",
        background: AppColors.paymentbaground,
        iconColor: AppColors.paymentIcon,
        onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BlocProvider(
        create: (_) => PersonolBloc(ProfileService())
          ..add(LoadPersonolData(FirebaseAuth.instance.currentUser!.uid)),
        child: const PersonolScreen(),
      ),
    ),
  );
}

      ),

      _buildSettingTile(
        context,
        icon: Icons.location_on_outlined,
        title: "Saved Address",
        background: AppColors.adressbaground,
        iconColor: AppColors.adressIcon,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => AdressScreen(),
          ));
        },
      ),

      _buildSettingTile(
        context,
        icon: Icons.payment_outlined,
        title: "Payment Method",
        background: AppColors.settingbaground,
        iconColor: AppColors.settingsIcon,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => PaymentScreen(),
          ));
        },
      ),
    ],
  );
}

static Widget _buildSettingTile(
  BuildContext context, {
  required IconData icon,
  required String title,
  required Color background,
  required Color iconColor,
  required VoidCallback onTap,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(0, 3),
          blurRadius: 8,
        )
      ],
    ),
    child: ListTile(
      minLeadingWidth: 0,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Icon(
            icon,
            size: 28,
            color: iconColor,
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.blackColor,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      onTap: onTap,
    ),
  );
}

 




 
    }



          
  























