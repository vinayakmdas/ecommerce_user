
abstract class PaymentMethodEvent {}

 class SelectPaymentMethod  extends PaymentMethodEvent {

  final  String   method;
   SelectPaymentMethod (this.method);

  
}
