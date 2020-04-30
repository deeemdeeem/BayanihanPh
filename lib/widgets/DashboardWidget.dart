import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[Text('Dashboard Card'), Container()],
        ),
      ),
    );
  }
}
