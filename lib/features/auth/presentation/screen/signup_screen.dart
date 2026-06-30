import 'package:ecommerce_fasion/features/auth/data/model/signUp_Model.dart';
import 'package:ecommerce_fasion/features/auth/presentation/widget/singUpwidget.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller = TextEditingController();
  final TextEditingController phonenumbercontroller = TextEditingController();

  final SignupModel signupModel = SignupModel();
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    emailcontroller.dispose();
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    phonenumbercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBaground,
      body: Padding(
        padding: const EdgeInsets.only(top: 234, left: 25, right: 25),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Signupwidget.appwelcomeText(context),
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
                Signupwidget.conformpassword(confirmpasswordcontroller),
                const SizedBox(height: 20),
                Signupwidget.phoneNumber(),
                SizedBox(height: 12),
                Signupwidget.phoneNumberField(phonenumbercontroller),
                SizedBox(height: 24),
                Signupwidget.termAndCondition(context),
                SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            if (formKey.currentState!.validate()) {
                              if (passwordcontroller.text ==
                                  confirmpasswordcontroller.text) {
                                setState(() {
                                  _isLoading = true;
                                });
                                await signupModel.signup(
                                  context: context,
                                  username: usernamecontroller.text.trim(),
                                  email: emailcontroller.text.trim(),
                                  password: passwordcontroller.text.trim(),
                                  phonenumber: phonenumbercontroller.text.trim(),
                                );
                                if (mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Password and Confirm Password do not match",
                                    ),
                                  ),
                                );
                              }
                            } else {
                              print("not valid");
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.addToCart,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
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
