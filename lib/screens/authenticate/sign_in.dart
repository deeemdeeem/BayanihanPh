import 'package:flutter/material.dart';
import 'package:helpinghand/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

final AuthService _auth = AuthService();

// text field state

String email = '';
String password = '';

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blueAccent[600],
          elevation: 0.0,
          title: Text('Bayanihan PH'),
         ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Sized box same as margin
              RaisedButton(
                color: Colors.blueAccent[200],
                child: Text(
                  'Sign In with Google',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  _auth.googleSignIn();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
