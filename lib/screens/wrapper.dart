import 'package:flutter/material.dart';
import 'package:helpinghand/screens/authenticate/authenticate.dart';
import 'package:helpinghand/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:helpinghand/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // user == null ? print("no user") : print("USER : " + user.displayName);
    // return Home or Authenticate widget depending
    // if the user is signed in or not
    return user == null ? Authenticate() : Dashboard();
  }
}
