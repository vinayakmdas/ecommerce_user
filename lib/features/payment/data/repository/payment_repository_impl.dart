import 'package:ecommerce_fasion/features/payment/data/datasource/razorpay_datasource.dart';
import 'package:ecommerce_fasion/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RazorpayDatasource datasource;

  PaymentRepositoryImpl(this.datasource);

  @override
  void startPayment({
    required int amount,
    required String name,
    required String description,
    required String email,
    required String phone,
  }) {
    datasource.openCheckout(
      amount: amount,
      name: name,
      description: description,
      email: email,
      phone: phone,
    );
  }
}
