import 'package:ecommerce_fasion/features/payment/domain/repository/payment_repository.dart';

class StartPaymentUsecase {

  final  PaymentRepository repository ;

  StartPaymentUsecase(this.repository);

  void call({
    required int amount,
    required String name,
    required String description,
    required String email,
    required String phone,
  }){

    repository.startPayment(amount: amount, name: name, description: description, email: email, phone: phone);
  }
}