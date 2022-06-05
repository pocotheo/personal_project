import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  CustomButton({required this.onPressed, required this.barAvailable});
  final GestureTapCallback onPressed;
  final bool barAvailable;

  @override
  Widget build(BuildContext context) {
    final String doorSvg = 'assets/door.svg';

    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: (barAvailable)
          ? InkWell(
              borderRadius: BorderRadius.circular(50),
              splashColor: Colors.pinkAccent,
              onTap: onPressed,
              child: SizedBox(
                width: 100,
                height: 50,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: Colors.black, width: 4),
                        borderRadius: BorderRadius.circular(50)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 10,
                          top: 4,
                          child: Text(
                            'Enter',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 9,
                          child:
                              SvgPicture.asset(doorSvg, height: 25, width: 10),
                        ),
                      ],
                    )),
              ),
            )
          : InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: onPressed,
              child: SizedBox(
                width: 100,
                height: 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black, width: 4),
                      borderRadius: BorderRadius.circular(50)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 11,
                        top: 5,
                        child: Text(
                          'Too far',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
