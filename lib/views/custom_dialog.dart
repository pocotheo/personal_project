import 'dart:ui';
import '../constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions;
  const CustomDialogBox(
      {Key? key, required this.title, required this.descriptions})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    final String doorSvg = 'assets/closed.svg';
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(Constants.padding),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                      size: 40,
                    )),
              ),
              SvgPicture.asset(doorSvg, height: 75, width: 30),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.descriptions,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ],
    );
  }
}
