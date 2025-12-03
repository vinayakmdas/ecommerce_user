import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/profile/presentation/widget/profileHeader.dart';
import 'package:ecommerce_fasion/features/profile/presentation/widget/profile_Body.dart';
import 'package:flutter/material.dart';

class ProfileMainScreen extends StatelessWidget {
  const ProfileMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Profileheader.buildHeader(),
          ),
          ProfileBody.buildBody(context),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ProfileBody.buildAccountList(context),
          ) 
        ],
      ),
    );
  }
}
