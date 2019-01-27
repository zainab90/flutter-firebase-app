import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Storage/Model/student.dart';
import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


// reference to firebase
final studentRef= FirebaseDatabase.instance.reference().child('student_db');

class StudentInformation extends StatefulWidget{

  Student myStudent;


// define constructor
  StudentInformation(this.myStudent);

  @override
  State<StatefulWidget> createState() {
    return new StateOfStudentInformation();
  }


}


class StateOfStudentInformation extends State<StudentInformation>{

  String studentImage;

  @override
  void initState() {
    super.initState();
    studentImage=widget.myStudent.getImageUrl;

  }


  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade200,
        title: Text('Student Info'),
      ),
      body: new Center(
        child:  ListView(
          padding: EdgeInsets.all(5.0),
          children: <Widget>[
            Container(
              child: Center(
                child: studentImage==null ?
                Text('no Image'): Image.network(studentImage+'?alt=media') ,
              ),
            ),
            
            Text(widget.myStudent.getName,
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),

            Text(widget.myStudent.getAge,
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),

            Text(widget.myStudent.getCity,
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(widget.myStudent.getDepartment,
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(widget.myStudent.getDescription,
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
          ],
        ),
      )




      );

  }

}