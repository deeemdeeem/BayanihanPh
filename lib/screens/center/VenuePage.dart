import 'package:flutter/material.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/models/reliefcenter.dart';

class VenuePage extends StatefulWidget {
  ReliefCenterModel model;

  VenuePage({this.model});

  @override
  _VenuePageState createState() => _VenuePageState();
}

class _VenuePageState extends State<VenuePage> {
  Map<String, dynamic> dataObj = {};
  List<Map<String, dynamic>> object = [
    {
      "clothing": 0,
    },
    {
      "water": 0,
    },
    {
      "food": 0,
    },
  ];

  updateData(Map<String, dynamic> data, int i) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                data.keys.toString().replaceAll('(', '').replaceAll(')', '')),
            content: TextField(
              keyboardType: TextInputType.number,
              onChanged: (str) {
                setState(() {
                  object[i][data.keys.first] = str;
                });
                print(object[i]);
              },
              decoration: InputDecoration(hintText: 'Enter amount'),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    dataObj = widget.model.acceptedGoods;
    print(dataObj);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> obj = [];
    widget.model.acceptedGoods.forEach((k, v) {
      obj.add({'$k': v});
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.model.reliefCenterName),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'For ${widget.model.calamityName}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: mBold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                object.length,
                (i) {
                  return Card(
                    child: ListTile(
                      onTap: () => updateData(object[i], i),
                      title: Text(
                        object[i]
                            .keys
                            .toString()
                            .replaceAll('(', '')
                            .replaceAll(')', ''),
                        style: TextStyle(
                          fontFamily: mBold,
                          fontSize: 15,
                        ),
                      ),
                      subtitle: Text(
                        object[i]
                            .values
                            .toString()
                            .replaceAll('(', '')
                            .replaceAll(')', ''),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final String goodName;
  final String amount;
  final Function subtractfunction;
  final Function addfunction;

  MyListTile(
      {this.goodName, this.amount, this.subtractfunction, this.addfunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black12,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Goods Name',
                    style: TextStyle(
                      fontFamily: mBold,
                      fontSize: 13,
                    )),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Amt',
                  style: TextStyle(
                    fontFamily: mMedium,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: subtractfunction,
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: addfunction,
                child: Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          )
        ],
      ),
    );
  }
}
