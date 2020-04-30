import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/providers/Venues.dart';
import 'package:helpinghand/screens/center/CreateVenue.dart';
import 'package:helpinghand/widgets/DashboardWidget.dart';
import 'package:helpinghand/widgets/DonationVenueList.dart';
import 'package:provider/provider.dart';
import 'package:helpinghand/services/auth.dart';
import 'package:helpinghand/models/user.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndexState createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return ChangeNotifierProvider(
      create: (context) => VenuesProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(
              fontFamily: mBold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateVenue(),
            ),
          ),
          icon: Icon(
            FontAwesomeIcons.plusCircle,
          ),
          label: Text(
            'Create Venue',
            style: TextStyle(
              fontFamily: mSemiBold,
            ),
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              // Important: Remove any padding from the ListView.
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(user.displayImage),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.blue,
                  ),
                  child: null,
                ),
                ListTile(
                  dense: false,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  leading: Icon(Icons.home),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      fontFamily: mSemiBold,
                    ),
                  ),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  title: Text(
                    'Donations',
                    style: TextStyle(
                      fontFamily: mSemiBold,
                    ),
                  ),
                  dense: false,
                  leading: Icon(
                    FontAwesomeIcons.donate,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                Expanded(child: SizedBox()),
                Card(
                  color: Colors.redAccent,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: ListTile(
                    onTap: () => _auth.googleSignOut(),
                    leading: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Sign out',
                      style: TextStyle(
                        fontFamily: mBold,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
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
                Expanded(flex: 1, child: Dashboard()),
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

                Expanded(
                  flex: 3,
                  child: Container(
                    child: DonationVenueListWidget(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
