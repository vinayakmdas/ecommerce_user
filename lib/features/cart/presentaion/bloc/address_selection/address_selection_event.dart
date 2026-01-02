abstract class AddressSelectionEvent {}

class SelectAddressEvent extends AddressSelectionEvent {
  final String addressId;

  SelectAddressEvent(this.addressId);
}
