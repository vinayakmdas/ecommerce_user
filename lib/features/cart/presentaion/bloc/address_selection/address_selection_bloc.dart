import 'package:flutter_bloc/flutter_bloc.dart';
import 'address_selection_event.dart';
import 'address_selection_state.dart';

class AddressSelectionBloc
    extends Bloc<AddressSelectionEvent, AddressSelectionState> {
  AddressSelectionBloc() : super(AddressSelectionState()) {
    on<SelectAddressEvent>((event, emit) {
      emit(state.copyWith(selectedAddressId: event.addressId));
    });
  }
}
