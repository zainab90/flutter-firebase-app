import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_app/Storage/Model/student.dart';
import 'dart:io';
import 'package:date_format/date_format.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

// reference to firebase
final studentRef= FirebaseDatabase.instance.reference().child('student_db');

class StudentScreen extends StatefulWidget{

  Student myStudent;

// define constructor
  StudentScreen(this.myStudent);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateOfStudentSscreen();
  }


}

class StateOfStudentSscreen extends State<StudentScreen>{
  File myImageFile;// for picking image and save it in file.
  TextEditingController _nameController;
  TextEditingController _ageController;
  TextEditingController _cityController;
  TextEditingController _departmentController;
  TextEditingController _descriptionController;

  picker() async{
    File img= await ImagePicker.pickImage(source: ImageSource.gallery);
    File vid= await ImagePicker.pickVideo(source: ImageSource.camera);// reoord video
    if (img != null){
      myImageFile=img;
      setState(() {


      });
    }

  }

  @override
  void initState() {
    super.initState();
    _nameController= TextEditingController(text: widget.myStudent.getName);
    _ageController= TextEditingController(text: widget.myStudent.getAge.toString());
    _cityController= TextEditingController(text: widget.myStudent.getCity);
    _departmentController= TextEditingController(text: widget.myStudent.getDepartment);
    _descriptionController= TextEditingController(text: widget.myStudent.getDescription);
  }


  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _cityController.dispose();
    _departmentController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade200,
        title: Text('Student Info'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: picker, child: Icon(Icons.camera_alt),),
      body: new ListView(
        padding: EdgeInsets.all(5.0),
          children: <Widget>[
            TextField(
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name:',
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),

            TextField(
              style: TextStyle(

                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
              controller: _ageController,
              decoration: InputDecoration(
                labelText: 'Age:',
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),

            TextField(
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Name:',
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            TextField(
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
              controller: _departmentController,
              decoration: InputDecoration(
                labelText: 'Department:',
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            TextField(
              style: TextStyle(
                color: Colors.purpleAccent,
                fontSize: 16.0,
              ),
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description:',
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),

             Container(
               child: Center(
                 child: myImageFile==null ? Text('no Image', style: TextStyle(fontWeight:FontWeight.bold),) : Image.file(myImageFile),
               ),
             ),
            
             Container(
                alignment: Alignment.center,
              child: new RaisedButton(
                color: Colors.deepPurpleAccent.shade100,
              padding: EdgeInsets.only(top:20.0,bottom: 20.0, left: 40.0, right: 40.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.deepPurpleAccent.shade200,width: 3.0,)

              ),
              child: (widget.myStudent.getId != null) ? Text('Update', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),) :Text('Add' , style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0)),


              onPressed: (){

              if (widget.myStudent.getId != null)
              { // update an existing student
                studentRef.child(widget.myStudent.getId).set({

                  'name':_nameController.text,
                  'age':_ageController.text,
                  'city':_cityController.text,
                  'department':_departmentController.text,
                  'description':_descriptionController.text,
                }).then((_){
                  Navigator.pop(context);
                });

              }

              else
              {
                // save new Student
                // to upload image

                var now = formatDate(new DateTime.now(), [yyyy,'-','mm','-',dd]);
                 // create an uniqe image path for each image

                 var fullImagPath='images/${_nameController.text}-$now'+'.jpg';//this syntex is used for storage


                 var fullImagPath2= 'images%2F${_nameController.text}-$now'+'.jpg';// this syntex is used to store the path into database

                 // create a ref location for each image.
                 final StorageReference storageRef= FirebaseStorage.instance.ref().child(fullImagPath);

                 // create a task for upload image.
                final StorageUploadTask uploadTask= storageRef.putFile(myImageFile);

                String part1='https://firebasestorage.googleapis.com/v0/b/myfire-e489d.appspot.com/o/';
                String fullImageUrl=part1+fullImagPath2;



                studentRef.push().set({
                  'name':_nameController.text,
                  'age':_ageController.text,
                  'city':_cityController.text,
                  'department':_departmentController.text,
                  'description':_descriptionController.text,
                  'imageUrl': fullImageUrl,
                }).then((_){
                  Navigator.pop(context);
                });

              }
            },
            )
            )
          ],
        ),

      );

  }

}