import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpinghand/models/reliefcenter.dart';
import 'package:helpinghand/models/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<ReliefCenterModel> reliefCenters = [];
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<User>(context);
    void fetchUserCenters() async {
      http.Client client = new http.Client();
      http.Response response = await client.get(
          'https://solutionchallenge-52ee8.firebaseio.com/reliefcenter.json');
      print(response.body);
      var body = jsonDecode(response.body);
      List<ReliefCenterModel> userCenters = [];
      body.forEach((k, v) {
        print(k);
        if (v['uid'] == prov.uid) {
          userCenters.add(ReliefCenterModel.fromJson(body['$k']));
        }
      });
      setState(() {
        reliefCenters = [...userCenters];
      });
    }

    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Center(
          child: FlatButton(
            onPressed: fetchUserCenters,
            color: Colors.blue,
            child: Text(
              'Fetch Data',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
