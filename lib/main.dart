import 'package:flutter/material.dart';
import 'package:helpinghand/screens/wrapper.dart';
import 'package:helpinghand/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:helpinghand/models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
