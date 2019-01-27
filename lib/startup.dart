import 'package:flutter/material.dart';

class StartupPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateOfStartup();
  }

}

class StateOfStartup extends State<StartupPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('FireBase Tutorail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10.0),),
            RaisedButton(
              onPressed: (){
                Navigator.of(context).pushNamed('/auth');
              },
              child: Text('Firebase Authentication Test'),
              color: Colors.green,
              textColor: Colors.white,
            ),
            Padding(padding: EdgeInsets.all(10.0),),
            RaisedButton(
              onPressed: (){Navigator.of(context).pushNamed('/storage');},
              child: Text('Firebase Storage Test'),
              color: Colors.green,
              textColor: Colors.white,
            ),



          ],

        ),
      ),
    );
  }

}