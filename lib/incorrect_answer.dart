import 'package:flutter/material.dart';

class incorrect extends StatefulWidget {
  incorrect({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _incorrectState createState() => _incorrectState();
}

class _incorrectState extends State<incorrect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(children: <Widget> [
          Row(children: <Widget>[
            Image.asset('assets/images/alien_incorrect.png',
              fit: BoxFit.cover,
              scale: 4.5,),
            
          ],)
        ])
      )
    );
  }
}