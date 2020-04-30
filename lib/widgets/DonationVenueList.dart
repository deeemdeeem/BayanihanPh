import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpinghand/models/reliefcenter.dart';
import 'package:helpinghand/models/user.dart';
import 'package:provider/provider.dart';
import '../providers/Venues.dart';
import 'package:http/http.dart' as http;

class DonationVenueListWidget extends StatefulWidget {
  // DonationVenueListWidget({@required this.list});

  @override
  _DonationVenueListWidgetState createState() =>
      _DonationVenueListWidgetState();
}

class _DonationVenueListWidgetState extends State<DonationVenueListWidget> {
  List<ReliefCenterModel> reliefCenters = [];
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final venueData = Provider.of<VenuesProvider>(context);
    final list = venueData.getVenues;
    final prov = Provider.of<User>(context);

    Future<List<ReliefCenterModel>> fetchUserCenters() async {
      setState(() {
        loading = true;
      });
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
        loading = false;
        reliefCenters = [...userCenters];
      });
      return reliefCenters;
    }

    return Container(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => VenueListItemWidget(
          name: list[index].name,
          mobile: list[index].mobile,
          coordinates: list[index].coordinates,
          location: list[index].location,
          supervisor: list[index].supervisor,
          telnumber: list[index].telnumber,
        ),
      ),
    );
  }
}

class VenueListItemWidget extends StatelessWidget {
  final String name;
  final String location;
  final String supervisor;
  final String coordinates;
  final String mobile;
  final String telnumber;
  VenueListItemWidget(
      {@required this.name,
      @required this.location,
      @required this.supervisor,
      @required this.mobile,
      @required this.telnumber,
      @required this.coordinates});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('$name'),
                  Text('$location'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
