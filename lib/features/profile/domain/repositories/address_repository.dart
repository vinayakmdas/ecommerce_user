
import '../entities/address_entity.dart';

abstract class AddressRepository {

  Future<AddressEntity> getCurrentAddress();
}
