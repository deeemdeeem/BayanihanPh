import 'package:flutter/material.dart';
import 'package:helpinghand/providers/Venues.dart';
import 'package:helpinghand/screens/center/CreateVenue.dart';
import 'package:helpinghand/widgets/DashboardWidget.dart';
import 'package:helpinghand/widgets/DonationVenueList.dart';
import 'package:provider/provider.dart';
import 'package:helpinghand/services/auth.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VenuesProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          actions: <Widget>[
            ClipOval(
              child: Material(
                color: Colors.blue, // button color
                child: InkWell(
                  splashColor: Colors.blueGrey, // inkwell color
                  child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(
                        Icons.create,
                        color: Colors.white,
                      )),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateVenue()));
                  },
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60,
                          // child: Container(child: ,),
                          backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80'),
                        ),
                        FlatButton(
                          child: Text('Logout'),
                          onPressed: () async {
                            await _auth.googleSignOut();
                          },
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  dense: false,
                  trailing: Text('Home'),
                  subtitle: Text('Home'),
                  title: Text('Home'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text('Donations'),
                  dense: false,
                  trailing: Text('Home'),
                  subtitle: Text('Home'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ),
        // backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Dashboard(),
                // RaisedButton(
                //   child: Icon(
                //     Icons.navigate_next,
                //   ),
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/locations');
                //   },
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 10,
                //   ),
                //   child: Text('Home'),
                // ),

                Container(
                  height: MediaQuery.of(context).size.height / 2,
                  child: DonationVenueListWidget(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
