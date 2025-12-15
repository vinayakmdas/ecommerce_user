import 'package:ecommerce_fasion/features/profile/domain/entities/address_entity.dart';
 

class AdressModel extends AddressEntity{

  AdressModel({
    required String fullName,
    required String phone,
    required String door,
    required String pincode,
    required String street,
    required String city,
    required String district,
    required String state,
    double? latitude,
    double? longitude,
  }) : super(
    fullName: fullName,
    phone: phone,
    door: door,
    pincode: pincode,
    street: street,
    city: city,
    district: district,
    state: state,
    latitude: latitude,
    longitude: longitude,
  );
 factory AdressModel.fromMap({
    required String pincode,
    required String state,
    required String district,
    required String city,
    required String street,
    double? latitude,
    double? longitude,
  }) {
    return AdressModel(
      fullName: '',
      phone: '',
      door: '',
      pincode: pincode,
      street: street,
      city: city,
      district: district,
      state: state,
      latitude: latitude,
      longitude: longitude,
    );
  }
} 