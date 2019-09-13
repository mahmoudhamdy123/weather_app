import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 25,
  color: Colors.blue,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 100.0,
);

const kTextFieldInputDecoration = InputDecoration(
      filled: true,
      fillColor: Colors.white,
      icon: Icon(
        Icons.location_city,
        color: Colors.white,
      ),
      hintText: 'Enter City Name',
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
);

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(
      color: Colors.blue,
    ),
  ),
  titleStyle: TextStyle(
    color: Color.fromRGBO(91, 55, 185, 1.0),
  ),
);



