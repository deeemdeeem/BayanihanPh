import 'package:flutter/foundation.dart';


class Venue {
  final String name;
  final String location;
  final String supervisor;
  final String coordinates;
  final String mobile;
  final String telnumber;
  final List<String> photos;
  Venue(
      {@required this.name,
      @required this.location,
      @required this.supervisor,
      @required this.mobile,
      this.photos,
      @required this.telnumber,
      @required this.coordinates});
}
