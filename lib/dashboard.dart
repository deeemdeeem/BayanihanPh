import 'package:flutter/material.dart';
import 'package:helpinghand/screens/center/CreateVenue.dart';
import 'package:helpinghand/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:helpinghand/models/user.dart';

//screens
import 'screens/home/Index.dart';
import 'package:helpinghand/screens/center/DonationVenue.dart';

void main() => runApp(Dashboard());

class Dashboard extends StatelessWidget {
  void request() {
    // Future.delayed(duration)
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.white,
        initialRoute: '/home',
        routes: {
          '/home': (context) => HomeIndex(),
          '/locations': (context) => DonationVenue(),
          '/createvenue': (context) => CreateVenue()
        },
        // home: Scaffold(
        //   backgroundColor: Colors.white,
        //   body: SafeArea(
        //     child: ,
        //   ),
        // ),
      ),
    );
  }
}
