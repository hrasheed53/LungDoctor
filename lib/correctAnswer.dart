import 'package:flutter/material.dart';

class Correct extends StatefulWidget {
  Correct({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CorrectState createState() => _CorrectState();
}

class _CorrectState extends State<Correct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: <Widget>[
      Row(
        children: <Widget>[
          Image.asset(
            'assets/images/alien.png',
            fit: BoxFit.cover,
            scale: 4.5,
          ),
        ],
      )
    ])));
  }
}
