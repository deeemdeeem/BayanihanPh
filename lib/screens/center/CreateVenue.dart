import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/models/user.dart';
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
  String _calamityName;
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

  // keys for validation
  final _calamityKey = GlobalKey<FormState>();
  final _venueKey = GlobalKey<FormState>();
  final _contactNameKey = GlobalKey<FormState>();
  final _contactNumberKey = GlobalKey<FormState>();
  final _deliveryTargetKey = GlobalKey<FormState>();

  TextEditingController _contactPersonController = TextEditingController();
  TextEditingController _centerNameController = TextEditingController();
  TextEditingController _contactNumberController = TextEditingController();
  TextEditingController _goodsStringController = TextEditingController();
  TextEditingController _deliverTargetNameController = TextEditingController();
  TextEditingController _calamityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialDate = DateTime.now();
    startDate = DateTime.now();
    startDayTime = TimeOfDay(hour: 9, minute: 0);
    initialDayTime = TimeOfDay.now();
    endDayTime = TimeOfDay(hour: 17, minute: 0);
    initialTime = DateTime.utc(now.year, now.month, now.day, 9);
  }

  _setCalamityName() {
    showDialog(
        context: context,
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
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if (_calamityKey.currentState.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                      fontFamily: mBlack,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
              title: Text(
                'Enter Calamity Name',
                style: TextStyle(fontFamily: mBold, fontSize: 15),
              ),
              content: Form(
                key: _calamityKey,
                child: TextFormField(
                  validator: (str) {
                    if (str.isEmpty) {
                      return 'Cannot leave the fields blank.';
                    }

                    return null;
                  },
                  controller: _calamityNameController,
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: mRegular,
                  ),
                  onChanged: (str) => (setState(
                      () => _calamityName = _calamityNameController.text)),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.backspace,
                        size: 15,
                      ),
                      onPressed: () =>
                          (setState(() => _calamityNameController.clear())),
                    ),
                    prefixIcon: Icon(
                      Icons.warning,
                      size: 15,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    hintText: 'Calamity Name',
                    hintStyle: TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ));
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
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              if (_venueKey.currentState.validate()) {
                Navigator.pop(context);
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
                fontFamily: mBlack,
              ),
            ),
          ),
        ],
        title: Text(
          'Enter Venue Name',
          style: TextStyle(fontFamily: mBold, fontSize: 15),
        ),
        content: Form(
          key: _venueKey,
          child: TextFormField(
            controller: _centerNameController,
            style: TextStyle(
              fontSize: 13,
              fontFamily: mRegular,
            ),
            validator: (str) {
              if (str.isEmpty) {
                return "Cannot leave the fields blank";
              }

              return null;
            },
            onChanged: (str) =>
                (setState(() => _centerName = _centerNameController.text)),
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.backspace,
                  size: 15.0,
                ),
                onPressed: () =>
                    (setState(() => _centerNameController.clear())),
              ),
              prefixIcon: Icon(
                Icons.map,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              hintText: 'Venue Name',
              hintStyle: TextStyle(fontSize: 13),
            ),
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
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              if (_contactNameKey.currentState.validate() &&
                  _contactNumberKey.currentState.validate()) {
                Navigator.pop(context);
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigoAccent,
                fontFamily: mBlack,
              ),
            ),
          ),
        ],
        title: Text(
          'Enter Contact Information',
          style: TextStyle(fontFamily: mBold, fontSize: 15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Form(
              key: _contactNameKey,
              child: TextFormField(
                validator: (str) {
                  if (str.isEmpty) {
                    return "Cannot leave the fields blank.";
                  }
                  return null;
                },
                controller: _contactPersonController,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: mRegular,
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
            ),
            SizedBox(
              height: 10,
            ),
            Form(
              key: _contactNumberKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _contactNumberController,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: mRegular,
                ),
                validator: (str) {
                  if (str.isEmpty) {
                    return "Cannot leave the fields blank.";
                  }
                  return null;
                },
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
      startDayTime = timeofday ?? TimeOfDay.now();
      didStartTimeChange = true;
    });
  }

  _setEndTime() async {
    TimeOfDay timeofday = await showTimePicker(
        context: context,
        initialTime: startDayTime,
        builder: (context, widget) {
          return widget;
        });

    setState(() {
      endDayTime = timeofday ?? TimeOfDay(hour: 9, minute: 00);
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
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (_deliveryTargetKey.currentState.validate()) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.indigoAccent,
                    fontFamily: mBlack,
                  ),
                ),
              ),
            ],
            title: Text('Delivery Target'),
            content: Form(
              key: _deliveryTargetKey,
              child: TextFormField(
                validator: (str) {
                  if (str.isEmpty) {
                    return "Cannot leave the fields blank";
                  }
                  return null;
                },
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
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Location>(context);
    final user = Provider.of<User>(context);
    void submitInformation() async {
      setState(() {
        isSending = true;
      });
      bool validateCalamityName = _calamityNameController.text.isEmpty;
      bool validateVenueName = _centerNameController.text.isEmpty;
      bool validateContactPerson = _contactPersonController.text.trim().isEmpty;
      bool validateContactNumer = _contactNumberController.text.trim().isEmpty;
      bool validateAvailability = selected.length == 0;
      bool validateStartDate = startDate == null;
      bool validateEndDate = endDate == null;
      bool validateStartTime = startDayTime == null;
      bool validateEndTime = endDayTime == null;
      bool validateAcceptedGoods = acceptedGoods.length == 0;
      bool validateDeliveryTarget = _deliverTargetNameController.text.isEmpty;
      bool validateHostLocation = provider.hostMarker == null;
      bool validateTargetLocation = provider.targetMarker == null;

      if (validateCalamityName ||
          validateVenueName ||
          validateContactPerson ||
          validateContactNumer ||
          validateAvailability ||
          validateStartDate ||
          validateEndDate ||
          validateStartTime ||
          validateEndTime ||
          validateAcceptedGoods ||
          validateDeliveryTarget ||
          validateHostLocation ||
          validateTargetLocation) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Oops! You missed something!'),
              );
            });
      }
      Map<String, dynamic> responseBody = {
        'uid': '${user.uid}',
        'acceptedGoods': acceptedGoods,
        'availability': selected,
        'availabilityTime': {
          'endTime': '${endDayTime.hour}:${endDayTime.minute}',
          'startTime': '${startDayTime.hour}:${startDayTime.minute}',
        },
        'calamityName': _calamityNameController.text,
        'dateRange': {
          'endDate':
              '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day}',
          'startDate':
              '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day}',
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
      provider.setHostMarker(provider.defaultMarker);
      provider.setTargetMarker(provider.defaultMarker);
      setState(() {
        isSending = false;
      });
    }

    return isSending
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Create Venue",
                style: TextStyle(
                  fontFamily: mBold,
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Card(
                    child: ListTile(
                      trailing: _calamityNameController.text.trim().length != 0
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(
                              FontAwesomeIcons.plusCircle,
                              color: Colors.indigo,
                            ),
                      onTap: _setCalamityName,
                      leading: Icon(
                        FontAwesomeIcons.handsHelping,
                        color: Colors.indigoAccent,
                      ),
                      title: Text(
                        '${_calamityNameController.text.trim().length == 0 ? 'Calamity Name' : _calamityNameController.text}',
                        style: TextStyle(
                          fontFamily:
                              _calamityNameController.text.trim().length == 0
                                  ? mMedium
                                  : mBold,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        'Set Calamity',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: mMedium,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      trailing: _centerNameController.text.trim().length == 0
                          ? Icon(
                              FontAwesomeIcons.plusCircle,
                              color: Colors.indigo,
                            )
                          : Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                      onTap: _setCenterName,
                      leading: Icon(
                        FontAwesomeIcons.mapMarkedAlt,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        '${_centerNameController.text.trim().length == 0 ? 'Venue Name' : _centerNameController.text}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily:
                              _centerNameController.text.trim().length == 0
                                  ? mMedium
                                  : mBold,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        'Set Name',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: mMedium,
                          fontSize: 13,
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
                      leading: Icon(
                        FontAwesomeIcons.phoneAlt,
                        color: Colors.black87,
                      ),
                      title: Text(
                        '${_contactPersonController.text.trim().length == 0 || _contactNumberController.text.trim().length == 0 ? 'Contact Person/Number' : _contactPersonController.text + '/' + _contactNumberController.text}',
                        style: TextStyle(
                          fontFamily: _contactPersonController.text
                                          .trim()
                                          .length ==
                                      0 ||
                                  _contactNumberController.text.trim().length ==
                                      0
                              ? mMedium
                              : mBold,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        'Set Contact',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: mMedium,
                          fontSize: 13,
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
                      leading: Icon(
                        FontAwesomeIcons.calendarDay,
                        color: Colors.deepPurple,
                      ),
                      title: Text(
                        selected.length == 0
                            ? 'Availability'
                            : '${selected.toSet().map((f) => f.substring(0, 3)).toList().toString().replaceAll('[', '').replaceAll(']', '')}',
                        style: TextStyle(
                          fontFamily: selected.length == 0 ? mMedium : mBold,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        'Set Days',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: mMedium,
                          fontSize: 13,
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
                            icon: Icon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.redAccent,
                            ),
                            onPressed: _setStartDate,
                          ),
                          Text(
                            !didEditStartDate
                                ? 'Start Date'
                                : '${DateFormat.EEEE().format(startDate)}, ${startDate.day}/${startDate.month}/${startDate.year}',
                            style: didEditStartDate
                                ? TextStyle(
                                    color: Colors.indigo,
                                    fontFamily: mMedium,
                                  )
                                : null,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.calendarAlt,
                              color: Colors.indigoAccent,
                            ),
                            onPressed: _setEndDate,
                          ),
                          Text(
                            !didEditEndDate
                                ? 'End Date'
                                : '${DateFormat.EEEE().format(endDate)}, ${endDate.day}/${endDate.month}/${endDate.year}',
                            style: didEditEndDate
                                ? TextStyle(
                                    color: Colors.indigo,
                                    fontFamily: mMedium,
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
                          Text(
                            didStartTimeChange
                                ? "${startDayTime.format(context)}"
                                : 'Start Time',
                            style: TextStyle(
                              fontFamily: mMedium,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(FontAwesomeIcons.solidClock),
                            onPressed: _setEndTime,
                          ),
                          Text(
                            didEndTimeChange
                                ? "${endDayTime.format(context)}"
                                : 'End Time',
                            style: TextStyle(
                              fontFamily: mMedium,
                              fontSize: 13,
                            ),
                          ),
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
                      leading: Icon(
                        FontAwesomeIcons.birthdayCake,
                        color: Colors.lightBlue,
                      ),
                      title: Text(
                        'Accepted Goods',
                        style: TextStyle(
                          fontFamily: mMedium,
                          fontSize: 13,
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
                          MaterialPageRoute(builder: (context) => HostMaps())),
                      leading: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.redAccent,
                      ),
                      title: Text(
                        'Host Location',
                        style: TextStyle(
                          fontFamily: mMedium,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        'Set Location',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: mMedium,
                          fontSize: 12,
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
                        '${_deliverTargetNameController.text.trim().length == 0 ? 'Delivery Target' : _deliverTargetNameController.text}',
                        style: TextStyle(
                          fontFamily: mMedium,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        'Set Target',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: mMedium,
                          fontSize: 12,
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TargetMaps())),
                      leading: Icon(
                        FontAwesomeIcons.mapMarkerAlt,
                        color: Colors.green,
                      ),
                      title: Text(
                        'Deliver Target Location',
                        style: TextStyle(
                          fontFamily: mMedium,
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        'Set Location',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: mMedium,
                          fontSize: 12,
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
                          fontFamily: mBold,
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
