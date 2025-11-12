import 'package:ecommerce_fasion/features/auth/presentation/signup/model/signUp_Model.dart';
import 'package:ecommerce_fasion/features/auth/presentation/signup/widget/singUpwidget.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController usernamecontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController confirmpasswordcontroller = TextEditingController();
    TextEditingController phonecontroller = TextEditingController();


    SignupModel signupModel =SignupModel();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      body: Padding(
        padding: const EdgeInsets.only(top: 234, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Signupwidget.appwelcomeText(),
                SizedBox(height: 34),
                Signupwidget.nameHeading(),
                const SizedBox(height: 12),
                Signupwidget.userName(usernamecontroller),
                Signupwidget.emailHeading(),
                const SizedBox(height: 12),
                Signupwidget.signUpMail(emailcontroller),
                const SizedBox(height: 20),
                Signupwidget.passwordHeading(),
                const SizedBox(height: 12),
                Signupwidget.passwordcontroller(passwordcontroller),
                const SizedBox(height: 20),
                Signupwidget.conformpasswordHeading(),
                const SizedBox(height: 12),
                Signupwidget.conformpassword(
                  confirmpasswordcontroller,
                  
                ),
                const SizedBox(height: 20),
                Signupwidget.phoneNumber(),
                SizedBox(height: 12),
                Signupwidget.phoneNumberField(phonecontroller),
                SizedBox(height: 24),
                Signupwidget.termAndCondition(),
                SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: ()async {

                      if(_formKey.currentState!.validate()){
                      if(passwordcontroller.text== confirmpasswordcontroller.text){
                       await signupModel.signup(
                        context: context,
                         username: usernamecontroller.text.trim(),
                          email: emailcontroller.text.trim(),
                           password: passwordcontroller.text.trim(),
                            phonenumber: passwordcontroller.text.trim());
                      }else{

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password and Confirm Password do not match")));
                      }
                      }else{
                        print("not valid");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.addToCart,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                     
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 18),
                Signupwidget.moveToLoginPage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
