import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';

class UserToDataBase{

  addNewUser(user, context){
    // create a refrence to DB.
    final firebaseRefrnce= FirebaseDatabase.instance.reference().child('users-db');
    firebaseRefrnce.push().set({
      'email':user.email,
      'uid': user.uid


    })
        .then((value){
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed('/home');
    })
        .catchError((error){});

  }




}
