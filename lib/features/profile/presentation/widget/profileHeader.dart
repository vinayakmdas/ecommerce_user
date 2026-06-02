import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/profilebloc/bloc/profile_image_bloc.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/profilebloc/bloc/profile_image_event.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/profilebloc/bloc/profile_image_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profileheader {
  static Widget buildHeader(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return Container(
        height: 300,
        width: double.infinity,
        color: AppColors.categoryTitle,
        child: const Center(
          child: Text(
            "User not logged in",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("user")
          .doc(currentUser.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            height: 300,
            width: double.infinity,
            color: AppColors.categoryTitle,
            child: const Center(
              child: Text(
                "Error loading profile",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final data = snapshot.data?.data();
        final String name = data?['username'] ?? currentUser.displayName ?? "Vinayak M";
        final String email = data?['email'] ?? currentUser.email ?? "vinayakMdaz@gmail.com";
        final String? profileImageUrl = data?['profileImage'];

        return Container(
          height: 300,
          width: double.infinity,
          color: AppColors.categoryTitle,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAvatar(context, profileImageUrl),
              const SizedBox(height: 15),
              _buildName(name),
              const SizedBox(height: 10),
              _buildEmail(email),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildAvatar(BuildContext context, String? currentImageUrl) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, blocState) {
            final bool isLoading = blocState is ProfileLoading;
            
            // Determine image source
            ImageProvider? imageProvider;
            if (currentImageUrl != null && currentImageUrl.isNotEmpty) {
              imageProvider = NetworkImage(currentImageUrl);
            }

            return CircleAvatar(
              radius: 49,
              backgroundColor: AppColors.circleBordercolor,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.circleavatarBaground,
                backgroundImage: imageProvider,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : (imageProvider == null
                        ? const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          )
                        : null),
              ),
            );
          },
        ),

        // Camera Icon
        Positioned(
          right: -5,
          bottom: -5,
          child: InkWell(
            onTap: () {
              context.read<ProfileBloc>().add(PickProfileImage());
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey),
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildName(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  static Widget _buildEmail(String email) {
    return Text(
      email,
      style: TextStyle(fontSize: 14, color: AppColors.white.withOpacity(0.9)),
    );
  }

  imagepicker() {}
}
