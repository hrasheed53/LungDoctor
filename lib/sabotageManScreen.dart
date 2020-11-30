import 'package:flutter/material.dart';

class Sabotage extends StatefulWidget {
  Sabotage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SabotageState createState() => _SabotageState();
}

class _SabotageState extends State<Sabotage> {
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
