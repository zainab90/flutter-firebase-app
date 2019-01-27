import 'package:flutter/material.dart';
import 'package:flutter_app/startup.dart';
import 'package:flutter_app/authApp/UI/login_page.dart';
import 'package:flutter_app/authApp/UI/register_page.dart';
import 'package:flutter_app/authApp/UI/home.dart';
import 'package:flutter_app/Storage/GUI/listview_student.dart';


void main (){

  runApp(new MaterialApp(
    home: StartupPage(),
    title: 'Firebase Tutorail',
    routes: <String, WidgetBuilder>{
      '/home':(BuildContext context)=> StartupPage(),
      '/auth':(BuildContext context)=> new LoginPage(),
      '/register': (BuildContext context) => new RegisterPage(),
      '/authHome': (BuildContext context) => new Home(),
      '/storage': (BuildContext context)=> new ListViewStudent(),
      '/login':(BuildContext context)=> new LoginPage(),
      

    },
  )
  );
}