
import 'package:flutter_bloc/flutter_bloc.dart';


part 'image_indicator_event.dart';
part 'image_indicator_state.dart';

class ImageIndicatorBloc extends Bloc<ImageIndicatorEvent, ImageIndicatorState> {
  ImageIndicatorBloc() : super((ImageIndicatorState(currentPage: 0))) {
    on<ImageIndicatorEvent>((event, emit) {

      emit(ImageIndicatorState(currentPage: event.index));
 
    });
  }
}
