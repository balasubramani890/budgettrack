import 'package:flutter/material.dart';

class Styles {
  static final inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.all(12.0),
  );

  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.blue, // Set button background color
    onPrimary: Colors.white, // Set text color
    padding: EdgeInsets.all(12.0), // Set padding for the button
  );
}
