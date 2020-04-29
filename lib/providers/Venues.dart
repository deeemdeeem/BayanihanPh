import 'package:flutter/material.dart';
import 'package:helpinghand/models/Venue.dart';

class VenuesProvider with ChangeNotifier {
  List<Venue> _venuelist = [
    Venue(
      name: 'Saint luise medical hospital',
      mobile: '094577231232',
      coordinates: 'fdsfdsfds',
      location: 'Makati central',
      supervisor: 'jessy tang',
      telnumber: '6211-387',
    ),
    Venue(
      name: 'Saint ronaldo medical hospital',
      mobile: '0934324343434',
      coordinates: 'fdsfdsfds',
      location: 'Makati central',
      supervisor: 'tan tang',
      telnumber: '6211-387',
    ),
  ];

  // void addVenue() {
  //   _venuelist.add(Venue());
  //   notifyListeners();
  // }

  List<Venue> get getVenues {
    return [..._venuelist];
  }

  // void updateDetails(){
  //   _venuelist[]
  // }

}
