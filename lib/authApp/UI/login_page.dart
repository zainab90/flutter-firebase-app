import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';





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
  FacebookLogin _myFacebookLogin= new FacebookLogin();
//  TwitterLogin _myTwitterLogin = new TwitterLogin(
//    consumerKey: 'kkOvaF1Mowy4JTvCxKTV5O1WF',
//    consumerSecret: 'ZECGsI6UUDBEUVGkJe4S5vd0FGqGxC3wMJCgsXgPRfjSwRFnyH',
//  );


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
        backgroundColor: Colors.deepOrange,
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
              color: Colors.green,
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
                  }).catchError((e){print (e);});


                });

              },
            ),

            SizedBox(height: 15.0),

            FlatButton(
              child: Text('Sign In with Facebook'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: _faceBookLogin
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


  Future<Null> _faceBookLogin() async {
    print('call login');
     FacebookLoginResult result = await _myFacebookLogin.logInWithReadPermissions(['email']).
     catchError((e){print('logInWithReadPermissions : $e');});

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        FirebaseAuth.instance.signInWithFacebook(accessToken: accessToken.token).then((FirebaseUser signedUser){
          print('user name login using facebook is : ${signedUser.displayName}');
          print('Logged in! Token: ${accessToken.token} User id: ${accessToken.userId} Expires: ${accessToken.expires}Permissions: ${accessToken.permissions}Declined permissions: ${accessToken.declinedPermissions}');
          Navigator.of(context).pushReplacementNamed('/authHome');
        }).
        catchError((e){print('FirebaseUser error is :  $e');});
      //
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
  


// code for sign-in using twitter
//  Future<Null> _twitterLogin () async{
//
//    final TwitterLoginResult result = await _myTwitterLogin.authorize().
//    catchError((e){
//      print('error in authorized $e');
//    });
//    switch (result.status) {
//      case TwitterLoginStatus.loggedIn:
//        FirebaseAuth.instance.signInWithTwitter(authToken: result.session.token, authTokenSecret: result.session.secret).
//        then((FirebaseUser signedUser){
//          print('session  username: ${result.session.username}');
//        print('session id is ${result.session.userId}');
//        print('signed user name in twitter is  ${signedUser.displayName}');
//        print('signed user id is ${signedUser.uid}');
//        Navigator.of(context).pushReplacementNamed('/authHome');
//
//        })
//            .catchError((e){
//              print('error in signedUser $e');
//        });
//
//
//
//
//
//    break;
//      case TwitterLoginStatus.cancelledByUser:
//        print('Login cancelled by user.');
//        break;
//      case TwitterLoginStatus.error:
//        print('Login error: ${result.errorMessage}');
//        break;
//    }
//
//
//
//
//
//
//  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

}

