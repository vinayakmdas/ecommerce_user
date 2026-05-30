import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/constants/razorpay_keys.dart';
import 'package:ecommerce_fasion/features/cart/presentaion/widget/order_service.dart';
import 'package:ecommerce_fasion/features/payment/presentation/screens/payment_error_screen.dart';
import 'package:ecommerce_fasion/features/payment/presentation/screens/payment_sucess_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {


  final int amount;
  final String email;
  final String adress; 

  const RazorpayScreen({
    super.key,
    
    required this.amount, 
    required this.email,
     required this.adress,
   
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

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _openCheckout();
    });
    print(widget.adress);
    print(widget.adress);
  }

  void _openCheckout() {
    var options = {
      'key': RazorpayKey.keyId,
      'amount': widget.amount * 100,
      'name': 'Ecommerce Fashion',
      'description': 'Order Payment',
      'prefill': {
        'email': widget.email,
        'contact': '8848561548',
      },
      'theme': {'color': '#000000'}
    };

    _razorpay.open(options);
  }

  Future<String> getUsername() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .get();

      if (doc.exists) {
        return doc['username'] ?? 'Unknown User';
      }
      return 'Unknown User';
    } catch (e) {
      print(e);
      return 'Unknown User';
    }
  }

void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  await OrderService.placeOrder(
    paymentId: response.paymentId ?? '',
    paymentMethod: "Razorpay",
    totalAmount: widget.amount,
    address: widget.adress,
    email: widget.email,
  );

  if (!mounted) return;

  final username = await getUsername();

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => PaymentSucessScreen(
        amount: widget.amount.toString(),
        receiptName: username,
        transferId: response.paymentId ?? '',
        dataTime: DateTime.now().toString(),
        paymetMethod: "Razorpay",
      ),
    ),
  );
  print("work");
}

  void _handlePaymentError(PaymentFailureResponse response) {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PaymentErrorScreen(),
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: Center(child: CircularProgressIndicator(
     
        )),
      ),
    );
  }
}