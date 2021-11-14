import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Auth{


   Future signUp(String email,String password, ) async {
     try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email:email ,
          password: password
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
       String message="";
      if (e.code == 'weak-password') {
        message='The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message='The account already exists for that email.';
      }
      //Scaffold.of(context).showSnackBar((SnackBar(content: Text(message))));
    } catch (e) {
      print(e);
    }
  }


   Future login(String email,String password,) async {
    try {
      UserCredential userCredential  = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email:email ,
          password: password
      );
       return userCredential.user;

    } on FirebaseAuthException catch (e) {
      String message="";
      if (e.code == 'user-not-found') {
        message='No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message='Wrong password provided for that user.';
      }
      //Scaffold.of(context).showSnackBar((SnackBar(content: Text(message))));
    } catch (e) {
      print(e);
    }
  }

 Future logout()async{
    await FirebaseAuth.instance.signOut();
  }
}

