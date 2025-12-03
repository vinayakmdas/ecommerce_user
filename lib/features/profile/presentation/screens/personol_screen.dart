import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/profile/data/model/user_model.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/personoBloc/personol_bloc_bloc.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/personoBloc/personol_bloc_event.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/personoBloc/personol_bloc_state.dart';
import 'package:ecommerce_fasion/features/profile/presentation/widget/personol_screen_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonolScreen extends StatelessWidget {
  const PersonolScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Personal Data"),
        backgroundColor: AppColors.categoryTitle,
        foregroundColor: AppColors.white,
        centerTitle: true,
      ),

      body: BlocConsumer<PersonolBloc, PersonolState>(
        listener: (context, state) {
         if (state is PesonolDataLoaded) {
            usernameController.text = state.user.username;
            phoneController.text = state.user.phonenumber;
            emailController.text = state.user.email;
          }

          if(state is PersonolDataUpdated){

                ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Profile Updated")),
            );
          }



                  
        },
        builder: (context, state) {

          if(state is PersoloDataLoading){
            return Center(child: CircularProgressIndicator(color: AppColors.categoryTitle));
          }
          return Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          const Text(
                            "Update Your Information",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Name Label + Field
                          PersonolData.nameText(),
                          const SizedBox(height: 8),
                          PersonolData.nameTextField(
                            controller: usernameController,
                          ),

                          const SizedBox(height: 20),

                          // Phone Label + Field
                          PersonolData.phonenuumber(),
                          const SizedBox(height: 8),
                          PersonolData.phoneTextField(
                            controller: phoneController,
                          ),

                          const SizedBox(height: 20),

                          // Email Label + Field
                          PersonolData.emailText(),
                          const SizedBox(height: 8),
                          PersonolData.emailTextField(
                            controller: emailController,
                          ),

                          const SizedBox(height: 30),

                          // Save Button
                         SizedBox(
                          width: double.infinity,
                           child: ElevatedButton(
                                                 style: ElevatedButton.styleFrom(
                                                   padding: const EdgeInsets.symmetric(vertical: 14),
                                                   backgroundColor: AppColors.errormessage,
                                                   shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                                                   ),
                                                 ),
                                                 onPressed: () {
                                                 final uid = FirebaseAuth.instance.currentUser!.uid;
                                               context.read<PersonolBloc>().add(
                                                 UpdatePersonolData(
                                                   uid,
                                                   UserModel(
                            username   : usernameController.text.trim(),
                            phonenumber: phoneController.text.trim(),
                            email: emailController.text.trim(),
                                                   ),
                                                 ),
                                               );
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
                         ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
