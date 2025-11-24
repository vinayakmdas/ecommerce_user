import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupModel {

 final FirebaseAuth  _auth = FirebaseAuth.instance;
 final FirebaseFirestore firestore =  FirebaseFirestore.instance;

  Future<void> signup({
  required BuildContext context,
  required String username,
  required String email,
  required String password,
  required String phonenumber,
}) async {
 

 try{

 UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
 await firestore.collection("user").doc(userCredential .user!.uid).set({

  'uid':userCredential.user!.uid,
  'username': username,
  'email': email,
  'phonenumber': phonenumber,
 
 });
  ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );

 }on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The password provided is too weak.')),
      );
  } else if (e.code == 'email-already-in-use') {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('The account already exists for that email.')),
      );
  }
 } 
 
 
 
 catch(e){

  ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create account: $e')),
      );
 }


    }
}