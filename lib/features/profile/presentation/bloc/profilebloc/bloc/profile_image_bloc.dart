import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/features/profile/domain/repositories/ProfileRepository.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/profilebloc/bloc/profile_image_event.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/profilebloc/bloc/profile_image_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Profilerepository repository;
  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<PickProfileImage>(pickImage);
  }

  Future<void> pickImage(
    PickProfileImage event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileLoading());
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;

      final file = File(image.path);

      final imageUrl = await repository.uploadImage(file);

      if (imageUrl == null) {
        emit(ProfileError("Upload failed"));
        return;
      }
      print(imageUrl);
      await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"profileImage": imageUrl});
      emit(ProfileSuccess(imageUrl));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
