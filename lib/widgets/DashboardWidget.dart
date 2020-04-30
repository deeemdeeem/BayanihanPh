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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<User>(context);

    return Container(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          image: DecorationImage(
            image: AssetImage('assets/bayanihan.png'),
          ),
        ),
      ),
    );
  }
}
