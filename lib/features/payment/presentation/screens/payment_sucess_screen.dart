import 'package:ecommerce_fasion/core/theme/presentaion/colors.dart';
import 'package:ecommerce_fasion/features/payment/presentation/widget/payment_sucess.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';

import 'package:screenshot/screenshot.dart';

class PaymentSucessScreen extends StatefulWidget {
  
  final String amount ;
  final String receiptName;
    final String transferId;
    final String    dataTime;
    final String  paymetMethod;
  const PaymentSucessScreen({super.key,
  required this.amount 
   , required this.receiptName,
   required this.transferId,
   required this.dataTime,
   required this.paymetMethod
  });



  @override
  State<PaymentSucessScreen> createState() => _PaymentSucessScreenState();
}

class _PaymentSucessScreenState extends State<PaymentSucessScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              children: [
          

                PaymentSucessWidget.showpaymentDetails(widget.amount),

                const SizedBox(height: 20),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.paymenticonlogoBaground,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.receipt_long,
                              color: Color.fromARGB(255, 106, 206, 109),
                            ),
                          ),
                          title: const Text(
                            "Transaction Receipt",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text(
                            "Details of your transfer",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        const Divider(),

                   PaymentSucessWidget.     buildRow("Recipient Name", widget.receiptName),
                     PaymentSucessWidget.   buildRow("Transaction ID", widget.transferId),
                     PaymentSucessWidget.   buildRow("Date & Time", widget.dataTime),
                  PaymentSucessWidget.      buildRow("Payment Method", widget.paymetMethod),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// ---------------- DOWNLOAD BUTTON ----------------
                PaymentSucessWidget.dowloadingTrasferPage(context, screenshotController),

                const SizedBox(height: 20),

                /// ---------------- BACK BUTTON ----------------
                PaymentSucessWidget.backToHome(context),
              ],
            ),
          ),
        ),
      ),
    );
  }


 
}
