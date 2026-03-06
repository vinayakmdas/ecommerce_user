import 'package:ecommerce_fasion/features/profile/domain/entities/address_entity.dart';
 

class AdressModel extends AddressEntity{

  AdressModel({
    required super.fullName,
    required super.phone,
    required super.door,
    required super.pincode,
    required super.street,
    required super.city,
    required super.district,
    required super.state,
    super.latitude,
    super.longitude,
  });
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