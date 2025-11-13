import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_indicator_event.dart';
part 'image_indicator_state.dart';

class ImageIndicatorBloc extends Bloc<ImageIndicatorEvent, ImageIndicatorState> {
  ImageIndicatorBloc() : super(ImageIndicatorInitial()) {
    on<ImageIndicatorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
