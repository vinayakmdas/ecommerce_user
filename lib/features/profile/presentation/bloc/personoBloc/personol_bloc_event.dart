import 'package:ecommerce_fasion/features/profile/data/model/user_model.dart';

abstract class PersonolEvent {}

class LoadPersonolData extends PersonolEvent {
  final String uid;
  LoadPersonolData(this.uid);
}

class UpdatePersonolData extends PersonolEvent {
  final String uid;
  final UserModel user;
  UpdatePersonolData(this.uid, this.user);
}
