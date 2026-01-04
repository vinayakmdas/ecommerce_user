



import 'package:ecommerce_fasion/features/cart/presentaion/bloc/payment_method/payment_method_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'payment_method_event.dart';

class PaymentMethodBloc   extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  PaymentMethodBloc() : super(PaymentMethodState()) {
    on<SelectPaymentMethod>((event, emit) {
      emit(state.copyWith(selectedMethod: event.method));
    });
  }
}
