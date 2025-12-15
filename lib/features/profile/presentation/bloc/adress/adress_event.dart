
import 'package:equatable/equatable.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCurrentAddress extends AddressEvent {}
