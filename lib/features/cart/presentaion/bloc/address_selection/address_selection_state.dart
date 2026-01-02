class AddressSelectionState {
  final String? selectedAddressId;

  AddressSelectionState({this.selectedAddressId});

  AddressSelectionState copyWith({String? selectedAddressId}) {
    return AddressSelectionState(
      selectedAddressId: selectedAddressId,
    );
  }
}
  