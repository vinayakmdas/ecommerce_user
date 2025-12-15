import 'package:ecommerce_fasion/features/profile/data/datasources/location_data_sources.dart';
import 'package:ecommerce_fasion/features/profile/data/model/adress_model.dart';
import 'package:ecommerce_fasion/features/profile/domain/entities/address_entity.dart';
import 'package:ecommerce_fasion/features/profile/domain/repositories/address_repository.dart';
class AddressRepositoryImpl extends AddressRepository {
  final LocationDataSources dataSources;

  AddressRepositoryImpl(this.dataSources);

  @override
  Future<AddressEntity> getCurrentAddress() async {
    final position = await dataSources.getCurrentPossition();
    final placemarks = await dataSources.getPlacemarkFromPosition(
      position.latitude,
      position.longitude,
    );

    final p = placemarks.isNotEmpty ? placemarks.first : null;

    final pincode = p?.postalCode ?? '';
    final state = p?.administrativeArea ?? '';
    final city = p?.locality ?? p?.subLocality ?? '';

    final district =
        p?.subAdministrativeArea ?? '';

    final street =
        '${p?.street ?? ''}, ${p?.subLocality ?? ''}'.trim();

    return AdressModel.fromMap(
      city: city,
      district: district,
      pincode: pincode,
      state: state,
      street: street,
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
