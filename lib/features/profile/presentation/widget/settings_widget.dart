import 'package:ecommerce_fasion/core/navigation/constants/app_Navigator.dart';
import 'package:ecommerce_fasion/features/auth/presentation/screen/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsWidget {
  static logoutfunciton(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    await FirebaseAuth.instance.signOut();
    AppNavigator.pushAndRemoveUntil(context, Loginscreen());
  }

  static final preference = SharedPreferences.getInstance;
  static showLogoutDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout_rounded, color: Colors.orange),
              SizedBox(width: 8),
              Text("Logout"),
            ],
          ),
          content: const Text(
            "Are you sure you want to logout from your account?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                await logoutfunciton(context);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }
}
