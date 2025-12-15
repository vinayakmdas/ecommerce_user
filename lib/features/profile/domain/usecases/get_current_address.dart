import 'package:ecommerce_fasion/features/profile/domain/entities/address_entity.dart';
import 'package:ecommerce_fasion/features/profile/domain/repositories/address_repository.dart';

class GetCurrentAddress {

  final AddressRepository repository;


  GetCurrentAddress(this.repository);

  Future<AddressEntity> call()async{

    return await repository.getCurrentAddress();
  }
}