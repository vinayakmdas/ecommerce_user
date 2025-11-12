import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'select_index_event.dart';
part 'select_index_state.dart';

class SelectIndexBloc extends Cubit<int> {
  SelectIndexBloc() : super(0) ;
  

    void changevalue(int index)=> emit(index);
}
