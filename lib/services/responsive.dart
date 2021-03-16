import 'package:flutter/material.dart';
class Responsive extends StatelessWidget {
  const Responsive({Key key, this.child}) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 800;
  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width >= 800 && MediaQuery.of(context).size.width < 1200 ;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width < 800;
  static double sWidth(BuildContext context) => MediaQuery. of(context). size. width;
  static double sHeight(BuildContext context) => MediaQuery. of(context). size. height;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(child: child,);
  }
}