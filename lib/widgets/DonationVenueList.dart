import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:helpinghand/models/reliefcenter.dart';
import 'package:helpinghand/models/user.dart';
import 'package:helpinghand/screens/center/VenuePage.dart';
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
  @override
  Widget build(BuildContext context) {
    final venueData = Provider.of<VenuesProvider>(context);
    final list = venueData.getVenues;
    final prov = Provider.of<User>(context);

    Future<List<ReliefCenterModel>> fetchUserCenters() async {
      http.Client client = new http.Client();
      http.Response response = await client.get(
          'https://solutionchallenge-52ee8.firebaseio.com/reliefcenter.json');
      var body = jsonDecode(response.body);
      List<ReliefCenterModel> userCenters = [];
      body.forEach(
        (k, v) {
          Map<String, dynamic> withId = {
            'id': k,
            'body': body['$k'],
          };
          if (v['uid'] == prov.uid) {
            userCenters.add(ReliefCenterModel.fromJson(withId));
          }
        },
      );
      return userCenters;
    }

    return Container(
      child: FutureBuilder<List<ReliefCenterModel>>(
          future: fetchUserCenters(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ReliefCenterModel>> snapshot) {
            print(snapshot.connectionState);
            print(snapshot.hasData);
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Container(
                  height: 100,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Loading')
                      ],
                    ),
                  ),
                );

                break;
              case ConnectionState.done:
                print(snapshot.data);
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VenuePage(
                                  model: snapshot.data[i],
                                ),
                              )),
                          title: Text(snapshot.data[i].reliefCenterName),
                          subtitle: Text(snapshot.data[i].calamityName),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  );
                } else {
                  return Text('No Data');
                }
                break;
              default:
                return Center(
                  child: Column(
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text('Loading')
                    ],
                  ),
                );
                break;
            }
            ;
          }),
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
