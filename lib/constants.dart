import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xff7B73F9);
Color kPrimaryLightColor = Color(0xff94949D);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
const kInputDecoration = InputDecoration(
  hintText: 'Enter your password.',
  contentPadding:
  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
class Constants{

  static String myName = "yashraj";
  static const kPrimaryColorDark = Color(0xff143959);
  static const kBGColorDark = Color(0xff2f2e41);
  static const kPrimaryColorLight = Color(0xff1f7396);
  static const kPrimaryColorGreen = Color(0xff27D3A8);
  static const kPrimaryColorMoreLight = Color(0xffc7e6ff);
  static const kPrimaryColorSkin = Color(0xffF8E7AE);
  static const kPrimaryColorWhite = Color(0xffffffff);

}