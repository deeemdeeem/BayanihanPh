import 'package:flutter/material.dart';

class CreateVenue extends StatefulWidget {
  @override
  _CreateVenueState createState() => _CreateVenueState();
}

class _CreateVenueState extends State<CreateVenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Create Venue '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    // alignLabelWithHint: true,
                    hasFloatingPlaceholder: true,
                    labelText: 'Venue Name',
                    prefixIcon: Icon(Icons.card_membership)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Location',
                    prefixIcon: Icon(Icons.add_location)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone_android)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Telephone Number',
                    prefixIcon: Icon(Icons.phone_in_talk)),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                    labelText: 'Coordinates', prefixIcon: Icon(Icons.map)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
