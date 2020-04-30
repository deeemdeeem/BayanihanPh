import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Location extends ChangeNotifier {
  double _hostLat = 0.0;
  double _hostLon = 0.0;
  double _targetLat = 0.0;
  double _targetLon = 0.0;
  Marker _hostMarker = Marker(
    point: LatLng(14.590499, 120.980817),
    builder: (context) => Icon(
      Icons.location_on,
      color: Colors.redAccent,
    ),
  );
  Marker defaultMarker = Marker(
    point: LatLng(14.590499, 120.980817),
    builder: (context) => Icon(
      Icons.location_on,
      color: Colors.redAccent,
    ),
  );
  Marker _targetMarker = Marker(
    point: LatLng(14.590499, 120.980817),
    builder: (context) => Icon(
      Icons.location_on,
      color: Colors.green,
    ),
  );

  double get hostLat => _hostLat;
  double get hostLon => _hostLon;
  double get targetLat => _targetLat;
  double get targetLon => _targetLon;

  Marker get hostMarker => _hostMarker;
  Marker get targetMarker => _targetMarker;

  setHostMarker(Marker marker) {
    _hostMarker = marker;
    notifyListeners();
  }

  setTargetMarker(Marker marker) {
    _targetMarker = marker;
    notifyListeners();
  }

  setHostLat(double lat) {
    _hostLat = lat;
    notifyListeners();
  }

  setHostLon(double lon) {
    _hostLon = lon;
    notifyListeners();
  }

  setTargetLat(double lat) {
    _targetLat = lat;
    notifyListeners();
  }

  setTargetLon(double lon) {
    _targetLon = lon;
    notifyListeners();
  }
}
