// lib/features/address/presentation/bloc/address_state.dart
import 'package:ecommerce_fasion/features/profile/domain/entities/address_entity.dart';
import 'package:equatable/equatable.dart';


abstract class AddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final AddressEntity address;
  AddressLoaded(this.address);
  @override
  List<Object?> get props => [address];
}

class AddressFailure extends AddressState {
  final String message;
  AddressFailure(this.message);
  @override
  List<Object?> get props => [message];
}
