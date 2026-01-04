import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/constants/razorpay_keys.dart';

class RazorpayScreen extends StatefulWidget {
  final int amount;
  final String email;

  const RazorpayScreen({
    super.key,
    required this.amount,
    required this.email,
  });

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      _handlePaymentSuccess,
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      _handlePaymentError,
    );

    _razorpay.on(
      Razorpay.EVENT_EXTERNAL_WALLET,
      _handleExternalWallet,
    );

    _openCheckout();
  }

  void _openCheckout() {
    var options = {
      'key': RazorpayKey.keyId,
      'amount': widget.amount * 100, // paise
      'name': 'Ecommerce Fashion',
      'description': 'Order Payment',
      'prefill': {
        'email': widget.email,
        'contact': '9999999999',
      },
      'theme': {
        'color': '#000000',
      }
    };

    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await FirebaseFirestore.instance.collection("orders").add({
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "paymentId": response.paymentId,
      "amount": widget.amount,
      "paymentMethod": "UPI",
      "status": "success",
      "createdAt": Timestamp.now(),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Payment Successful")),
    );

    Navigator.pop(context); // back to checkout
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed")),
    );
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void dispose() {
    _razorpay.clear(); // VERY IMPORTANT
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
