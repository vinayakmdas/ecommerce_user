import 'dart:io';

import 'package:ecommerce_fasion/core/navigation/constants/app_Navigator.dart';
import 'package:ecommerce_fasion/core/navigation/presentaion/screen/navigator.dart';
import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

class PaymentSucessWidget{

 static  Widget buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$title :",
            style: TextStyle(color: AppColors.green),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  static Future<void> downloadReceipt(BuildContext context , ScreenshotController screenshotController) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      await Future.delayed(const Duration(milliseconds: 300));

      final permission = await Permission.storage.request();
      if (!permission.isGranted) {
        Navigator.pop(context);
        return;
      }

      final image = await screenshotController.capture(
        delay: const Duration(milliseconds: 200),
      );

      if (image == null) {
        Navigator.pop(context);
        return;
      }

      final directory = await getExternalStorageDirectory();
      final file = File(
        "${directory!.path}/receipt_${DateTime.now().millisecondsSinceEpoch}.png",
      );

      await file.writeAsBytes(image);

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Receipt downloaded successfully ✅"),
        ),
      );
    } catch (e) {
      Navigator.pop(context);
      debugPrint("Download error: $e");
    }
  }


  static  showpaymentDetails(String amount){

    return Stack(
                  children: [
                    Lottie.asset(
                      "assets/lottie/gopay succesfull payment.json",
                      repeat: false,
                    ),
                    Positioned(
                      top: 300,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          Text(
                            "Payment Successful",
                            style: GoogleFonts.neuton(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            amount,
                            style: GoogleFonts.neuton(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
  }



  // dowloadbutton 

  static   dowloadingTrasferPage(BuildContext context ,  ScreenshotController screenshotController){

    return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.firstButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => PaymentSucessWidget.downloadReceipt(context, screenshotController),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.file_download_outlined,
                            color: AppColors.blackColor, size: 28),
                        const SizedBox(width: 10),
                        Text(
                          "Download Receipt",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ),
                );
  }


  // backtoHome 

  static backToHome( BuildContext context){
     return  SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: AppColors.firstButtonColor,
                          width: 2,
                        ),
                      ),
                    ),
                    onPressed: () {
                      print("backin");
                           AppNavigator.pushReplacement(context, BottomNavigator());
                    },
                    child: Text(
                      "Back to Home",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                );
  }

}