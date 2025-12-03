

import 'package:ecommerce_fasion/features/profile/data/service/profile_service.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/personoBloc/personol_bloc_event.dart';
import 'package:ecommerce_fasion/features/profile/presentation/bloc/personoBloc/personol_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonolBloc extends Bloc<PersonolEvent, PersonolState> {


final ProfileService profileService;

PersonolBloc(this.profileService) :  super (PersonolDataInitial()){

  on<LoadPersonolData>((event , emit)async{

  emit (PersoloDataLoading());
  

    try{

final user = await profileService.getUser(event.uid);
 emit(PesonolDataLoaded(user));

     }catch(e){
   
  emit(PersonolError(e.toString()));

    }
  });

 on<UpdatePersonolData>((event, emit) async {
      emit(PersoloDataLoading());
      try {
        await profileService.updateUser(event.uid, event.user);
        emit(PersonolDataUpdated());
      } catch (e) {
        emit(PersonolError(e.toString()));
      }
    });
}
}
