import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'variant_event.dart';
part 'variant_state.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  VariantBloc() : super(VariantState(selecedvarient: 0)) {
    on<VariantEvent>((event, emit) {
     
     emit(VariantState(selecedvarient: event.index));
    });
  }
}
