import 'package:flutter/material.dart';

class Incorrect extends StatefulWidget {
  Incorrect({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IncorrectState createState() => _IncorrectState();
}

class _IncorrectState extends State<Incorrect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(children: <Widget>[
      Row(
        children: <Widget>[
          Image.asset(
            'assets/images/alien_incorrect.png',
            fit: BoxFit.cover,
            scale: 4.5,
          ),
        ],
      )
    ])));
  }
}
