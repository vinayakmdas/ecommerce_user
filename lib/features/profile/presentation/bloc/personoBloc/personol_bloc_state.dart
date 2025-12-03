import 'package:ecommerce_fasion/features/profile/data/model/user_model.dart';


abstract class PersonolState{}


class PersonolDataInitial extends  PersonolState{}

class PersoloDataLoading extends PersonolState{}


class PesonolDataLoaded extends PersonolState{


final UserModel  user ;

PesonolDataLoaded(this.user);

}

class PersonolDataUpdated extends PersonolState{}

class PersonolError extends PersonolState {
  final String message;
  PersonolError(this.message);
}
