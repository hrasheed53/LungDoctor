import 'package:flutter/material.dart';

class correct extends StatefulWidget {
  correct({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _correctState createState() => _correctState();
}

class _correctState extends State<correct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget> [
          Row(children: <Widget>[
            Image.asset('assets/images/alien.png',
              fit: BoxFit.cover,
              scale: 4.5,),
            
          ],)
        ])
      )
    );
  }
}