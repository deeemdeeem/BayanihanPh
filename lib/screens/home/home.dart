import 'package:flutter/material.dart';
import 'package:helpinghand/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:helpinghand/models/user.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[600],
        title: Text('Bayanihan PH'),
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Image.network('https://lh3.googleusercontent.com/-L9t5OQH6Rdc/AAAAAAAAAAI/AAAAAAAAAAA/AAKWJJOFuB89Y-56Ca48eTHc_UQ-loqOow/s96-c/photo.jpg', height: 30.0, width: 30.0,),
            onPressed: () async {
              await _auth.googleSignOut();
            },
            label: Text(user.displayName),
          ),
        ],
      ),
    );
  }
}
