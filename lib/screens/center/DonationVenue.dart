import 'package:flutter/material.dart';

class DonationVenue extends StatefulWidget {
  @override
  _DonationVenueState createState() => _DonationVenueState();
}

class _DonationVenueState extends State<DonationVenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Locations'),
      ),
      body: SafeArea(
        child: Container(
          child: Text('donations'),
        ),
      ),
    );
  }
}
