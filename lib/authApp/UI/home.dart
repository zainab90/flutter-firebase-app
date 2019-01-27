import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateOfHome();
  }

}




class StateOfHome extends State<Home>{

String _userName='';
String _userId='';

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((FirebaseUser currentUser){
      // used built-in Firebase user parameters
      _userName=currentUser.email;
      print('from hom page : $_userName');
      _userId=currentUser.uid;
    }).catchError((error)
    {print(error);}
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$_userName',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade200, fontWeight: FontWeight.bold,fontSize: 20.0),
            ),
            SizedBox(height: 15.0),
            Text(
              '$_userId',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade200, fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            SizedBox(height: 15.0),

            Text(
              'Welcome Dashboard',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade200, fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            SizedBox(height: 15.0),

            FlatButton(
              child: Text('Sign Out'),
              textColor: Colors.white,
              color: Colors.deepOrange,
              onPressed: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.of(context).pushReplacementNamed('/login');
                }).catchError((){});
              },
            ),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

}

