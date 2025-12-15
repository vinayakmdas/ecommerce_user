// lib/features/address/presentation/bloc/address_bloc.dart
import 'package:ecommerce_fasion/features/profile/domain/usecases/get_current_address.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/adress/adress_event.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/adress/adress_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetCurrentAddress getCurrentAddress;

  AddressBloc({required this.getCurrentAddress}) : super(AddressInitial()) {
    on<FetchCurrentAddress>(_onFetchCurrentAddress);
  }

  Future<void> _onFetchCurrentAddress(FetchCurrentAddress event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    try {
      final addr = await getCurrentAddress();
      emit(AddressLoaded(addr));
    } catch (e) {
      emit(AddressFailure(e.toString()));
    }
  }
}
