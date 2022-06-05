import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';

import '../data.dart';
import '../models/user_location.dart';
import '../models/custom_button.dart';
import './custom_dialog.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    String distance(index) {
      var distanceBefore = Geolocator.distanceBetween(userLocation.latitude,
          userLocation.longitude, bars[index].latitude, bars[index].longitude);
      if (distanceBefore < 1000) {
        return "${distanceBefore.toStringAsFixed(0)}m away";
      } else {
        return "${(distanceBefore / 1000).toStringAsFixed(1)}km away";
      }
    }

    bool availableBar(index) {
      var distanceBefore = Geolocator.distanceBetween(userLocation.latitude,
          userLocation.longitude, bars[index].latitude, bars[index].longitude);
      if (distanceBefore < 100) {
        return true;
      } else {
        return false;
      }
    }

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Can’t open the door!",
            descriptions:
                "You have to be inside the venue or less than 100m away from the venue, to be able to enter it.",
          );
        },
      );
    }

    var statusBarH = MediaQuery.of(context).padding.top;
    var toolbarH = MediaQuery.of(context).size.height * 0.09;
    var imageHeight = MediaQuery.of(context).size.height * 0.2;

    bars.sort((a, b) => Geolocator.distanceBetween(userLocation.latitude,
            userLocation.longitude, a.latitude, a.longitude)
        .compareTo(Geolocator.distanceBetween(userLocation.latitude,
            userLocation.longitude, b.latitude, b.longitude)));

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.white,
        toolbarHeight: toolbarH,
        backgroundColor: Colors.white.withOpacity(0.7),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: statusBarH + toolbarH, bottom: 15),
        itemCount: bars.length,
        itemBuilder: (context, index) {
          return ColumnSuper(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 6,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2, 2))
                    ],
                    image: DecorationImage(
                      image: bars[index].image,
                      fit: BoxFit.fitWidth,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  height: imageHeight * 0.8,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.5),
                            offset: Offset(2, 2))
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(bars[index].name,
                                  style: Theme.of(context).textTheme.headline2),
                              Row(
                                children: [
                                  Icon(Icons.location_on_sharp),
                                  Text(
                                    distance(index),
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CustomButton(
                            onPressed:
                                (!availableBar(index)) ? _showMyDialog : () {},
                            barAvailable: availableBar(index),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            innerDistance: -imageHeight * 0.4,
          );
        },
      ),
    );
  }
}
