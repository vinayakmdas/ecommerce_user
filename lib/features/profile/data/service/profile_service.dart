import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fasion/features/profile/data/model/user_model.dart';

class ProfileService {

   final FirebaseFirestore firestore = FirebaseFirestore.instance;




   Future <UserModel> getUser(String uid)async{
   
   final doc = await  firestore.collection("user").doc(uid).get();

   return UserModel.fromMap(doc.data());

   }


    Future<void> updateUser(String uid, UserModel model) async {
    await firestore.collection("user").doc(uid).update(model.toMap());
  }
}