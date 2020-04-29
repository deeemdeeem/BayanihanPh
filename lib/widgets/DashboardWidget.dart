import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Card(
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[Text('Dashboard Card'), Container()],
          ),
        ),
      ),
    );
  }
}
