import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:helpinghand/providers/Location.dart';
import 'package:helpinghand/screens/maps/HostMaps.dart';
import 'package:helpinghand/screens/maps/TargetMaps.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CreateVenue extends StatefulWidget {
  @override
  _CreateVenueState createState() => _CreateVenueState();
}

class _CreateVenueState extends State<CreateVenue> {
  TimeOfDay initialDayTime;
  TimeOfDay startDayTime;
  TimeOfDay endDayTime;
  DateTime initialDate;
  DateTime startDate;
  DateTime endDate;
  DateTime initialTime;
  DateTime now = DateTime.now();
  String _centerName;
  String _contactPersonName;
  String _contactNumber;
  String _goodsString = "";
  String _deliverTargetName;
  bool didEditStartDate = false;
  bool didEditEndDate = false;
  bool didStartTimeChange = false;
  bool didEndTimeChange = false;
  bool isSending = false;
  List<String> acceptedGoods = [];
  List<String> selected = [];
  List<String> labels = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _centerNameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _goodsStringController = TextEditingController();
  TextEditingController _deliverTargetNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now();
    startDate = DateTime.now();
    startDayTime = TimeOfDay(hour: 9, minute: 0);
    initialDayTime = TimeOfDay.now();
    initialTime = DateTime.utc(now.year, now.month, now.day, 9);
  }

  _setCenterName() {
    showDialog(
      context: (context),
      builder: (context) => AlertDialog(
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Dismiss',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.indigo,
            child: Text(
              'Submit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Text('Enter Venue Name'),
        content: TextField(
          controller: _centerNameController,
          style: TextStyle(
            fontSize: 13,
          ),
          onChanged: (str) =>
              (setState(() => _centerName = _centerNameController.text)),
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                Icons.backspace,
              ),
              onPressed: () => (setState(() => _centerNameController.clear())),
            ),
            prefixIcon: Icon(
              Icons.person,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
            hintText: 'Center Name',
            hintStyle: TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }

  _setContactPerson() {
    showDialog(
      context: (context),
      builder: (context) => AlertDialog(
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Dismiss',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.indigo,
            child: Text(
              'Confirm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Text('Enter Contact Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _contactPersonController,
              style: TextStyle(
                fontSize: 13,
              ),
              onChanged: (str) => (setState(
                  () => _contactPersonName = _contactPersonController.text)),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.backspace,
                    size: 15,
                  ),
                  onPressed: () =>
                      (setState(() => _contactPersonController.clear())),
                ),
                prefixIcon: Icon(
                  Icons.person,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                hintText: 'Contact Person',
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _contactNumberController,
              style: TextStyle(
                fontSize: 13,
              ),
              onChanged: (str) => (setState(
                  () => _contactNumber = _contactNumberController.text)),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.backspace,
                    size: 15,
                  ),
                  onPressed: () =>
                      (setState(() => _contactNumberController.clear())),
                ),
                prefixIcon: Icon(
                  Icons.phone,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                hintText: 'Contact Number',
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _setDays() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 10),
        title: Text('Availability'),
        actions: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Dismiss',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.indigo,
            child: Text(
              'Submit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CheckboxGroup(
              labels: labels,
              onSelected: (checked) {
                setState(() {
                  selected = checked;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  _setStartDate() {
    DatePicker.showDatePicker(
      context,
      currentTime: startDate,
      minTime: initialDate,
      maxTime: DateTime.now().add(Duration(days: 60)),
      onChanged: (date) {
        setState(() {
          startDate = date;
          didEditStartDate = true;
        });
      },
    );
  }

  _setEndDate() => DatePicker.showDatePicker(
        context,
        currentTime: startDate,
        minTime: startDate,
        maxTime: startDate.add(Duration(days: 30)),
        onChanged: (date) {
          setState(() {
            endDate = date;
            didEditEndDate = true;
          });
        },
      );

  _setStartTime() async {
    TimeOfDay timeofday = await showTimePicker(
        context: context,
        initialTime: initialDayTime,
        builder: (context, widget) {
          return widget;
        });

    setState(() {
      startDayTime = timeofday;
      didStartTimeChange = true;
    });
  }

  _setEndTime() async {
    TimeOfDay timeofday = await showTimePicker(
        context: context,
        initialTime: initialDayTime,
        builder: (context, widget) {
          return widget;
        });

    setState(() {
      endDayTime = timeofday;
      didEndTimeChange = true;
    });
    print(timeofday);
  }

  _setAcceptedGoods() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (contetx, setState) {
          return AlertDialog(
            title: Text('Accepted Goods ${acceptedGoods.length}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 50,
                  width: double.infinity,
                  child: acceptedGoods.length == 0
                      ? Center(
                          child: Text(
                            'None',
                            style: TextStyle(fontSize: 13),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: acceptedGoods.length,
                          itemBuilder: (context, i) {
                            return Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 2.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      acceptedGoods[i],
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () => (setState(
                                        () => acceptedGoods.removeAt(i))),
                                    child: Icon(
                                      Icons.remove_circle,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                ),
                TextField(
                  controller: _goodsStringController,
                  onChanged: (str) => (setState(() => _goodsString = str)),
                  decoration: InputDecoration(
                    hintText: 'Type here...',
                    suffixIcon: IconButton(
                      iconSize: 20,
                      icon: Icon(
                        FontAwesomeIcons.plusCircle,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        if (_goodsString.trim().length != 0) {
                          setState(() {
                            acceptedGoods.add(_goodsString);
                            _goodsString = "";
                            _goodsStringController.clear();
                          });
                        } else {
                          print(acceptedGoods.length);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _setDeliverTargetName() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  'Dismiss',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                color: Colors.indigo,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            title: Text('Delivery Target'),
            content: TextField(
              controller: _deliverTargetNameController,
              style: TextStyle(
                fontSize: 13,
              ),
              onChanged: (str) => (setState(() =>
                  _deliverTargetName = _deliverTargetNameController.text)),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.backspace,
                  ),
                  onPressed: () =>
                      (setState(() => _deliverTargetNameController.clear())),
                ),
                prefixIcon: Icon(
                  Icons.person,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                hintText: 'Delivery Target',
                hintStyle: TextStyle(fontSize: 13),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Location>(context);
    void submitInformation() async {
      setState(() {
        isSending = true;
      });
      Map<String, dynamic> responseBody = {
        'acceptedGoods': acceptedGoods,
        'availability': selected,
        'availabilityTime': {
          'endTime': '${endDayTime.hour}:${endDayTime.minute}',
          'startTime': '${startDayTime.hour}:${startDayTime.minute}',
        },
        'calamityName': 'TestCalamity',
        'dateRange': {
          'endDate': '${endDate.year}-${endDate.month}-${endDate.day}',
          'startDate': '${startDate.year}-${startDate.month}-${startDate.day}',
        },
        'deliveryLocation': {
          'lat': provider.targetMarker.point.latitude.toString(),
          'long': provider.targetMarker.point.longitude.toString(),
        },
        'deliveryTarget': _deliverTargetNameController.text,
        'hostContact': _contactNumberController.text,
        'hostFname': _contactPersonController.text,
        'hostLname': 'Test',
        'hostLocation': {
          'lat': provider.hostMarker.point.latitude.toString(),
          'long': provider.hostMarker.point.longitude.toString(),
        },
        'isDelivered': false,
        'reliefCenterName': _centerNameController.text
      };

      print(responseBody);

      http.Client client = new http.Client();
      http.Response response = await client.post(
          'https://solutionchallenge-52ee8.firebaseio.com/reliefcenter.json',
          body: jsonEncode(responseBody));
      Navigator.pop(context);
      print(response.body);
      setState(() {
        isSending = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Venue"),
      ),
      body: Center(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Card(
              child: ListTile(
                trailing: Icon(
                  FontAwesomeIcons.plusCircle,
                  color: Colors.indigo,
                ),
                onTap: _setCenterName,
                leading: Icon(FontAwesomeIcons.handsHelping),
                title: Text(
                    '${_centerNameController.text.trim().length == 0 ? 'Venue Name' : _centerNameController.text}'),
                subtitle: Text(
                  'Set Name',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                trailing: Icon(
                  FontAwesomeIcons.plusCircle,
                  color: Colors.indigo,
                ),
                onTap: _setContactPerson,
                leading: Icon(FontAwesomeIcons.phoneAlt),
                title: Text(
                    '${_contactPersonController.text.trim().length == 0 || _contactNumberController.text.trim().length == 0 ? 'Contact Person/Number' : _contactPersonController.text + '/' + _contactNumberController.text}'),
                subtitle: Text(
                  'Set Contact',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                trailing: Icon(
                  FontAwesomeIcons.plusCircle,
                  color: Colors.indigo,
                ),
                onTap: _setDays,
                leading: Icon(FontAwesomeIcons.calendarDay),
                title: Text(selected.length == 0
                    ? 'Availability'
                    : '${selected.toSet().map((f) => f.substring(0, 3)).toList().toString().replaceAll('[', '').replaceAll(']', '')}'),
                subtitle: Text(
                  'Set Days',
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.calendarAlt),
                      onPressed: _setStartDate,
                    ),
                    Text(
                      !didEditStartDate
                          ? 'Start Date'
                          : '${DateFormat.EEEE().format(startDate)}, ${startDate.day}/${startDate.month}/${startDate.year}',
                      style: didEditStartDate
                          ? TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            )
                          : null,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.calendarAlt),
                      onPressed: _setEndDate,
                    ),
                    Text(
                      !didEditEndDate
                          ? 'End Date'
                          : '${DateFormat.EEEE().format(endDate)}, ${endDate.day}/${endDate.month}/${endDate.year}',
                      style: didEditEndDate
                          ? TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold,
                            )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.clock),
                      onPressed: _setStartTime,
                    ),
                    Text(didStartTimeChange
                        ? "${startDayTime.hour} : ${startDayTime.minute}"
                        : 'Start Time'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(FontAwesomeIcons.solidClock),
                      onPressed: _setEndTime,
                    ),
                    Text(didEndTimeChange
                        ? "${endDayTime.hour} : ${endDayTime.minute}"
                        : 'End Time'),
                  ],
                ),
              ],
            ),
            Card(
              child: ListTile(
                trailing: Icon(
                  FontAwesomeIcons.plusCircle,
                  color: Colors.indigo,
                ),
                onTap: _setAcceptedGoods,
                leading: Icon(FontAwesomeIcons.birthdayCake),
                title: Text('Accepted Goods'),
              ),
            ),
            Card(
              child: ListTile(
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HostMaps())),
                leading: Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.redAccent,
                ),
                title: Text('Host Location'),
                subtitle: Text(
                  'Set Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: _setDeliverTargetName,
                leading: Icon(
                  Icons.location_searching,
                  size: 30,
                ),
                title: Text(
                    '${_deliverTargetNameController.text.trim().length == 0 ? 'Delivery Target' : _deliverTargetNameController.text}'),
                subtitle: Text(
                  'Set Target',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TargetMaps())),
                leading: Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  color: Colors.green,
                ),
                title: Text('Deliver Target Location'),
                subtitle: Text(
                  'Set Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RaisedButton(
                color: Colors.indigo,
                onPressed: submitInformation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
