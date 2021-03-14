import 'package:flutter/material.dart';
class CurvedButton extends StatelessWidget {
  CurvedButton({
    @required this.fuc,@required this.txt
  }) ;
  final String txt;
  final Function fuc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: fuc,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            txt,style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}