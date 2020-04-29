import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Venues.dart';

class DonationVenueListWidget extends StatelessWidget {
  // DonationVenueListWidget({@required this.list});

  @override
  Widget build(BuildContext context) {
    final venueData = Provider.of<VenuesProvider>(context);
    final list = venueData.getVenues;
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => VenueListItemWidget(
        name: list[index].name,
        mobile: list[index].mobile,
        coordinates: list[index].coordinates,
        location: list[index].location,
        supervisor: list[index].supervisor,
        telnumber: list[index].telnumber,
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
