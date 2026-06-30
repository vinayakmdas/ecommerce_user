import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/profile/domain/repositories/ProfileRepository.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/profilebloc/bloc/profile_image_bloc.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/profilebloc/bloc/profile_image_state.dart';
import 'package:ecommerce_fasion/features/profile/presentation/widget/profileHeader.dart';
import 'package:ecommerce_fasion/features/profile/presentation/widget/profile_Body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileMainScreen extends StatelessWidget {
  const ProfileMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(Profilerepository()),
      child: Builder(
        builder: (context) {
          return BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Profile image updated successfully!"),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is ProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Upload failed: ${state.message}"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.scafoldBaground,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Profileheader.buildHeader(context),
                    ),
                    ProfileBody.buildBody(context),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: ProfileBody.buildAccountList(context),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

