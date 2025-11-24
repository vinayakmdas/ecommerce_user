
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState(isFavorite: false)) {
    on<FavoriteEvent>((event, emit) {
      emit  (FavoriteState(isFavorite: event.isFav));
    });
  }
}
