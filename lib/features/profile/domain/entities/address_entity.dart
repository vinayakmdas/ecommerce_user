// lib/features/address/domain/entities/address_entity.dart
class AddressEntity {
  final String fullName;
  final String phone;
  final String door;
  final String pincode;
  final String street;
  final String city;
  final String district;
  final String state;
  final double? latitude;
  final double? longitude;

  AddressEntity({
    required this.fullName,
    required this.phone,
    required this.door,
    required this.pincode,
    required this.street,
    required this.city,
    required this.district,
    required this.state,
    this.latitude,
    this.longitude,
  });
}
