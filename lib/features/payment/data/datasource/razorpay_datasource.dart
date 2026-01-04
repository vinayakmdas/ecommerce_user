import 'package:ecommerce_fasion/core/constants/razorpay_keys.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

abstract class RazorpayDatasource {

  void openCheckout({
    required int amount,
    required String name,
    required String description,
    required String email,
    required String phone,
  });
}


class RazorpayDatasourceImpl implements  RazorpayDatasource{

   
   final Razorpay razorpay ;
    RazorpayDatasourceImpl (this.razorpay);
 
 @override

void openCheckout({
     required int amount,
    required String name,
    required String description,
    required String email,
    required String phone,}){
  
  var options = {

'key':RazorpayKey.keyId,
'amount':amount*100,
  'name': name,
  'description': description,
  'prefill': {
     'contact': phone,
        'email': email,
  },
   'theme': {
        'color': '#000000'
      }

   
  };
   razorpay.open(options);
}
 
}