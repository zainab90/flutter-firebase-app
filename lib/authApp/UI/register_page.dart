import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/authApp/Utiles/user_to_database.dart';


class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new StateOfRegisterPage();
  }

}





class StateOfRegisterPage extends State<RegisterPage>{
  TextEditingController _emailController;
  TextEditingController _passwordController;


  @override
  void initState() {
    super.initState();
    _emailController= new TextEditingController();
    _passwordController=new TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
                labelStyle: TextStyle(fontStyle: FontStyle.italic,  color: Colors.green),
              ),
            ),
            SizedBox(height: 15.0,),

            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.vpn_key),
                labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Colors.green),
              ),
            ),
            
            SizedBox(height: 15.0,),
            FlatButton(
              child: Text('Register'),
              textColor: Colors.white,
              color: Colors.deepOrange,
              onPressed: (){
                FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
                    .then((FirebaseUser signedUser){
                      UserToDataBase().addNewUser(signedUser, context);
                })
                    .catchError((error){print(error);});

                // Navigator.pushNamed(context, '/register');
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/authHome');
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
    _emailController.dispose();
    _passwordController.dispose();
  }

}

