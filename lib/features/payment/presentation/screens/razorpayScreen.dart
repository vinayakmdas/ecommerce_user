import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/core/constants/razorpay_keys.dart';
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
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  // 1️⃣ Get Cart Items
  final cartSnapshot = await firestore
      .collection("cart")
      .doc(uid)
      .collection("items")
      .get();

  final cartItems = cartSnapshot.docs;

  if (cartItems.isEmpty) return;

String sellerId = cartItems.first["sellerId"].toString();
  // 2️⃣ Create Order Document
  final orderRef = firestore.collection("orders").doc();
String displayOrderId =
    "#ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}";
  await orderRef.set({
    "userId": uid,
    "amount": widget.amount,
    "paymentId": response.paymentId,
    "status": "success",
    "createdAt": Timestamp.now(),
    "sellerId":  sellerId
  });

  // 3️⃣ Add Items inside order/items
  for (var item in cartItems) {
    final data = item.data();

    await orderRef.collection("items").add({
      "adress" : widget.adress,
      "orderId" : displayOrderId,
      "productId": item.id,
      "productName": data["productName"],
      "price": data["price"],
      "qty": data["qty"],
      "sellerId": data["sellerId"],
      "image": data["images"][0],
      "status": "pending",
      
    });
  }

  // 4️⃣ Clear Cart
  for (var item in cartItems) {
    await item.reference.delete();
  }

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
