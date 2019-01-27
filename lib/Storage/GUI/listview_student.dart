
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:flutter_app/Storage/Model/student.dart';
import 'package:flutter_app/Storage/GUI/student_screen.dart';
import 'package:flutter_app/Storage/GUI/student_information.dart';


final studentRef= FirebaseDatabase.instance.reference().child('student_db');
// student_db it is a name of database in firebase



class ListViewStudent extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateOfListStudent();
  }


}

class StateOfListStudent extends State<ListViewStudent> {

  List <Student> items;
  StreamSubscription<Event> _onStudentAddedSubscription; // realtime listener for firebase
  StreamSubscription<Event> _onStudentChangedSubscription;

  @override
  void initState() {
    super.initState();
    //initalize the list
    items = new List();
    // initalize the listener and also initialize the list from firebase realtime database
    _onStudentAddedSubscription = studentRef.onChildAdded.listen(_onStudentAdded);
    _onStudentChangedSubscription = studentRef.onChildChanged.listen(_onStudentUpdated);
  }




  @override
  void dispose() {
    super.dispose();
    // close the connection with firebase
    _onStudentAddedSubscription.cancel();
    _onStudentChangedSubscription.cancel();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade200,
        title: new Text('Students Info'),
        centerTitle: true,
      ),

      floatingActionButton: new FloatingActionButton(
          child: Icon(Icons.person_add, color: Colors.white,),
          backgroundColor: Colors.deepPurpleAccent.shade200,
          onPressed: ()=> _createNewStudent(context)
      ),

      body: Center(

        child: ListView.builder(

            itemCount: items.length,

            padding: EdgeInsets.only(top: 12.0),

            itemBuilder: (context , position){

              return Column(

                children: <Widget>[

                  Divider(height: 10.0,
                  color: Colors.purple,),

                  Container(

                    child: Center(

                      child: '${items[position].getImageUrl}' == ''

                          ? Text('No Image')

                          :
                      Image.network(

                        '${items[position].getImageUrl}'+'?alt=media',

                        height: 300.0,

                        width: 400.0,
                      //  fit: BoxFit.fill,

                      ),

                    ),

                  ),


                  Card(

                    child:   Row(

                      children: <Widget>[

                        Expanded(child:   ListTile(

                            title: Text(

                              '${items[position].getName}',

                              style: TextStyle(

                                color: Colors.blueAccent,

                                fontSize: 22.0,

                              ),

                            ),

                            subtitle:  Text(

                              '${items[position].getDescription}',

                              style: TextStyle(

                                color: Colors.blueGrey,

                                fontSize: 14.0,

                              ),

                            ),

                            leading: Column(

                              children: <Widget>[

                                CircleAvatar(

                                  backgroundColor: Colors.amberAccent,

                                  radius: 18.0,

                                  child: Text('${position + 1}' ,

                                    style: TextStyle(

                                      color: Colors.black,

                                      fontSize: 15.0,

                                    ),),

                                ),



                              ],

                            ),

                            onTap:  () => _showStudentInfo(context, items[position] )

                        ),
                        )
                        ,



                        IconButton(

                            icon: Icon(Icons.delete,color: Colors.red,)

                            , onPressed: () => _deleteStudent(context,position, items[position])

                        ),

                        IconButton(

                            icon: Icon(Icons.edit,color: Colors.blue,)

                            , onPressed: () => _navigateToStudentScreen(context, items[position])

                        )



                      ],

                    ),

                  ),







                ],



              );



            }

        ),

      ),










    );
  }



  void _onStudentAdded(Event event){
    setState(() {
      items.add(Student.fromSnapshot(event.snapshot));
    });

  }

  void  _onStudentUpdated(Event event){

    var oldStudent= items.singleWhere((myStudent){
      return myStudent.getId.toString()== event.snapshot.key;
    });

    items[items.indexOf(oldStudent)]= Student.fromSnapshot(event.snapshot);
  }


  void _createNewStudent(BuildContext context) async{
    debugPrint('start Adding');
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentScreen(Student(null, '', null, '', '', '',''))));

  }

  void _deleteStudent(BuildContext context, int position, Student stu) async{
    await studentRef.child(stu.getId.toString()).remove().then((_){
      setState(() {
        items.removeAt(position);
      });
    });


  }

  void  _showStudentInfo(BuildContext context, Student stu) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentInformation(stu)));
  }


  void  _navigateToStudentScreen(BuildContext context, Student stu) async{
    await Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentScreen(stu)));
  }




}