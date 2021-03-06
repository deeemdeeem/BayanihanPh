import 'package:flutter/material.dart';
import 'package:helpinghand/screens/authenticate/sign_in.dart';
import 'package:helpinghand/screens/authenticate/register.dart';
import 'package:helpinghand/screens/authenticate/video.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: showSignIn==true?
      SignIn(toggleView: toggleView)
      :
      Register(toggleView: toggleView)
    );
  }
}