import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'QuicksandBold',
  fontSize: 220.0,
  fontWeight: FontWeight.w900,
  height: 0.93,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'QuicksandBold',
  fontSize: 50.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'QuicksandBold',
  color: Colors.white,
);

const kConditionTextStyle = TextStyle(
  fontSize: 50.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter city name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15.0),
    ),
    borderSide: BorderSide.none,
  ),
);
