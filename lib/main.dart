import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './services/location_service.dart';
import './models/user_location.dart';
import './views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>(
      initialData: UserLocation(44.78648, 41.1241),
      create: (context) => LocationService().locationStream,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.black,
          fontFamily: "Muli",
          textTheme: const TextTheme(
              headline1: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headline2: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              headline3: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              subtitle1: TextStyle(fontSize: 10.0, color: Colors.black),
              subtitle2: TextStyle(fontSize: 15.0, color: Colors.black)),
        ),
        title: 'List View',
        home: MyHomePage(title: 'Clubs near me'),
      ),
    );
  }
}
