

 class PaymentMethodState {
  final String? selectedMethod;

  PaymentMethodState({this.selectedMethod});

  PaymentMethodState copyWith({String? selectedMethod}) {
    return PaymentMethodState(
      selectedMethod: selectedMethod ?? this.selectedMethod,
    );
  }
}
