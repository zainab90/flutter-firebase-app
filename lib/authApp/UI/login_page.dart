import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  new StateOfLoginPage();
  }

}


class StateOfLoginPage extends State<LoginPage>{
  TextEditingController _emailController;
  TextEditingController _passwordController;
  GoogleSignIn _googleSignIn= new GoogleSignIn();


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
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(14.0),
        child: SingleChildScrollView(
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
              child: Text('Login'),
              textColor: Colors.white,
              color: Colors.deepOrange,
              onPressed: (){
                // login operation( send email and password to firebase database)
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
                    .then((FirebaseUser user){ // if everything is ok , then go to Home Page.
                      Navigator.of(context).pushReplacementNamed('/authHome');
                }).
                catchError((error)
                {print(error);}
                );
                },
            ),
            SizedBox(height: 15.0,),
            Text(
              'Or',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade400, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.0),

            FlatButton(
              child: Text('Sign In with Google'),
              textColor: Colors.white,
              color: Colors.red,
              onPressed: (){
                
                _googleSignIn.signIn().then((GoogleSignInAccount _signInAccount){
                  _signInAccount.authentication.then((GoogleSignInAuthentication googleKey){
                    FirebaseAuth.instance
                        .signInWithGoogle(idToken: googleKey.idToken, accessToken: googleKey.accessToken)
                        .then((FirebaseUser user){

                          print(' User on Google Account : $user');
                          // if everything is ok , then go to Home Page.
                      Navigator.of(context).pushReplacementNamed('/authHome');
                    }).
                    catchError((error)
                    {print('error in login wth google is : $error');}
                    );
                  }).catchError((){});


                });

              },
            ),
            SizedBox(height: 15.0),
            Text(
                'Don\'t have an account!',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade400, fontWeight: FontWeight.bold, fontSize: 25.0),
            ),
            SizedBox(height: 15.0),

            FlatButton(
              child: Text('Register'),
              textColor: Colors.white,
              color: Colors.deepOrange,
              onPressed: (){
               // Navigator.pushNamed(context, '/register');
                Navigator.of(context).pushNamed('/register');
              },
            ),








          ],
        ),
      ),)

    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

}

